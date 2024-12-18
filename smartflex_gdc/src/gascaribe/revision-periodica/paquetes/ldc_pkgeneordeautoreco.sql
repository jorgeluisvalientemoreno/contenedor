CREATE OR REPLACE PACKAGE LDC_PKGENEORDEAUTORECO  IS
/**************************************************************************
    Autor       : Elkin Alvarez / Horbath
    Fecha       : 2019-24-01
    Ticket      : 200-2231
    Descripcion : Paquete para la gestión de autoreconectados

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR                      DESCRIPCION
    24/01/2018  Elkin Alvarez / Horbath     Creación
    21/08/2019  Mateo Velez / OLSOFTWARE    modificacion del cursor cuValidaOrde
    05/07/2020  OLsoftware.CA47             Se crea GeneraPerscaAuto y 
                                            GeneraPerscaNoAuto
    22/11/2020  OLsoftware.CA452            Se modifica GeneraPerscaAuto
                                            Se crea fsbPermiteRegistroAutoRec
    09/12/2020  ljlb                        CA 337 se modifica GeneraPerscaAuto		
    12/05/2021  OLSoftware                  CA519: se modifica GeneraPerscaAuto
    03/05/2023	jpinedc-MVM                 OSF-1075: se modifica GeneraPerscaAuto								  
    24/05/2023	jpinedc-MVM                 OSF-1075: se modifica GeneraPerscaAuto
    02/05/2023	jpinedc-MVM                 OSF-1169: se modifica GeneraPerscaAuto
    21/11/2023	jpinedc-MVM                 OSF-1635: se modifica GeneraPerscaAuto		                                                           				              
    21/02/2024	jpinedc-MVM                 OSF-2341: se crean: 
                                            prgeneraPerscaCadJobs
                                            prIniCadenaJobsPERSCA
                                            prFinCadenaJobsPERSCA
                                            prcTotales
    22/03/2024	jpinedc-MVM                 OSF-2341: se crean: 
                                            pCreaCadenaJobsPERSCAAutom
                                            prgeneraPerscaCadJobsAutom
    02/04/2024  jpinedc - MVM               OSF-2341: * Se pasan los permisos a otro archivo
                                            * Se usa PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                            * Se usa PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
    29/05/2024  jpinedc - MVM               OSF-2341: * Se borra la variable sender
***************************************************************************/

    -- Lista de procesos de Autoreconectados
    cnuLDC_PROCAUTORECO   CONSTANT ld_parameter.numeric_value%TYPE
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_PROCAUTORECO') ;

    -- Lista de procesos de Autoreconectados Servicios Nuevos        
    csbPROCAUTORECO_SN    CONSTANT ld_parameter.value_chain%TYPE
        := pkg_BCLD_Parameter.fsbObtieneValorCadena ('PROCAUTORECO_SN') ;
            
    -- Valida si el producto debe iniciar proceso de persecucion por autoreconexion   
    FUNCTION fnugetValidaAuto (inuProducto IN servsusc.sesunuse%type, inuProceso ldc_proceso.proceso_id%TYPE) RETURN NUMBER;

    -- proceso que se encarga de generar persecion
    PROCEDURE progeneraPersca( isbProgram      IN  VARCHAR2,
                            inuProceso      IN  NUMBER,
                            inuCICLO        IN  NUMBER,
                            inuDepartamento IN  NUMBER,
                            inuLocalidad    IN  NUMBER,
                            inuHilo         IN  NUMBER,
                            inuTotalHilos   IN  NUMBER);
                            
    -- Valida si el proceso ya terminó
    PROCEDURE VerificaFinProceso
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        inuCantHilos    IN   NUMBER,
        onuCantRegist   OUT  NUMBER,
        onuCantPerse    OUT  NUMBER
    );

    -- Proceso que se encarga de generar flujo de autoreconectado
    PROCEDURE PROGENEACTAUTORECO(inuConsecutivo IN  LDC_SUSP_AUTORECO.SARECODI%TYPE);

    -- Proceso que se encarga de generar venta de servicio de ingenieria
    PROCEDURE LDC_PROGENTRAMVSI;

    -- Proceso que se encarga de validar lecturas
    PROCEDURE LDC_VALILECTAUTO;
   
    -- proceso que se encarga de validar si un producto esta suspendido por RP
    PROCEDURE LDC_PROVALIESTAPRSU;

    -- Proceso que se encarga de generar tramite de reinstalacion y reco rp
    PROCEDURE LDC_PROCREASOLIRECOSINCERT;
         	 
    -- Retorna X si el producto no es facturable, S si volumen neto facturaro es mayor al tolerado
    FUNCTION fsbVolFactMayToler( inuProducto NUMBER, inuSeSuEsCo NUMBER, idtFechaSusp DATE, inuSeSuCiCo NUMBER )
    RETURN VARCHAR2; 
        
    -- Valida los parámetros usados exclusivamente en proceso de autoreconetados
    PROCEDURE pValParAutorecon( inuProceso NUMBER );
    
    -- Retorna la fecha inicial para el calculo del volumen facturado
    FUNCTION fdtFechIniVolFact ( idtFechaSusp DATE ) 
    RETURN DATE;
    
    -- Genera la cadena de Jobs de PERSCA
    PROCEDURE prgeneraPerscaCadJobs
    (
        isbProgram      VARCHAR2, 
        inuProceso      NUMBER, 
        isbCiclo        VARCHAR2, 
        isbDepartamento VARCHAR2, 
        isbLocalidad    VARCHAR2, 
        inuTotalHilos   NUMBER,
        inuLogProcessId ge_log_process.log_process_id%TYPE           
    );
        
    -- Progama inicial de la cadena de Jobs de PERSCA
    PROCEDURE prIniCadenaJobsPERSCA
    ( 
        isbProgram      VARCHAR2,
        inuProceso      NUMBER,
        inuCiclo        NUMBER,
        inuDepartamento NUMBER,
        inuLocalidad    NUMBER,
        inuLogProcessId      ge_log_process.log_process_id%TYPE        
    );
    
    -- Progama final de la cadena de Jobs de PERSCA    
    PROCEDURE prFinCadenaJobsPERSCA
    (
        isbProgram      VARCHAR2,    
        inuProceso      NUMBER,
        inuCiclo        NUMBER,
        inuDepartamento NUMBER,
        inuLocalidad    NUMBER,
        inuTotalHilos   NUMBER
    );

    -- Obtiene los totales del proceso
    PROCEDURE prcTotales
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        onuCantRegist   OUT  NUMBER,
        onuCantPerse    OUT  NUMBER
    );
    
    -- Crea cadena de Jobs para procesos de ejecución automática
    PROCEDURE pCreaCadenaJobsPERSCAAutom(inuTotalHilos NUMBER);
    
    -- Crea cadena de Jobs para procesos de ejecución automática si no se esta ejecutando
    PROCEDURE prgeneraPerscaCadJobsAutom;
        
END LDC_PKGENEORDEAUTORECO;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKGENEORDEAUTORECO  IS

    nuPaso                  NUMBER;

    cnuTOLEREANCIA_DIF               NUMBER := NVL (
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                       'TOLERANCIA_DIFE_AUTORECONE'),
                   0);
                                             
                                                                 

    cnuTOLEREANCIA_DIFSN              NUMBER := NVL (
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                       'TOLERANCIA_DIFE_AUTORECONE_SN'),
                   0);
                   
    gnuToleranciaDif               NUMBER;
    
    cnuCONCEPTO_CONSUMO CONSTANT    concepto.conccodi%TYPE := 31;
    
    csbCAUSCARG_PERSCA  CONSTANT    LD_PARAMETER.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena (
                       'CAUSCARG_PERSCA');
                       
    cnuMESES_PERSCA_AUTORECO CONSTANT NUMBER := pkg_parametros.fnuGetValorNumerico('MESES_PERSCA_AUTORECO');
                       
    TYPE tytbEscoFact IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
    
    gtbEscoFact tytbEscoFact;
    
    gsbConsulta              VARCHAR2(32000);
    
    gblgtbPrNoValiAutoreco BOOLEAN := FALSE;
    
    TYPE tytbPrNoValiAutoreco IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    
    gtbPrNoValiAutoreco      tytbPrNoValiAutoreco;
    
    cnuSERV_GAS              CONSTANT servicio.servcodi%TYPE := 7014;
    
    TYPE    tytbTISU_GENERA_PERSEC_REPA IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
    
    gtbTiSuGeneraPersecRepa   tytbTISU_GENERA_PERSEC_REPA;
    
    csbTIPO_SUSP_GENE_PERS         CONSTANT LDC_PARAREPE.paravast%TYPE := daLDC_PARAREPE.fsbGetPARAVAST('TIPOSUSP_GENERA_PERSEC_REPA',NULL);

    csbCOMA                        VARCHAR2(1) := ',';

    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;  
        
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
        
    gsbProgramIndi           VARCHAR2(2000) := 'PERSCA_INDIV';

	-- Declaracion de variables y tipos globales privados del paquete
	gsbChainJobsPERSCA  VARCHAR2(30) := 'CADENA_JOBS_'|| gsbProgramIndi ;

    gsbProgramAuto           VARCHAR2(2000) := 'PERSCA_AUTOM';
    
	-- Declaracion de variables y tipos globales privados del paquete
	gsbChainJobsPERSCAAutom  VARCHAR2(30) := 'CADENA_JOBS_'|| gsbProgramAuto;
	
    sbRecipients    VARCHAR2(2000);	

    tbSchedChainProg  pkg_Scheduler.tytbSchedChainProg;
    
    CURSOR cuProcesosAutomaticos
    IS
    SELECT *
    FROM ldc_proceso
    WHERE proceso_automatico = 'S'
    ORDER BY proceso_id;
    
    TYPE tytbProcesosAutomaticos IS TABLE OF cuProcesosAutomaticos%ROWTYPE
    INDEX BY BINARY_INTEGER;
        
    tbProcesosAutomaticos tytbProcesosAutomaticos;    
                    
    -- Carga la tabla global gtbTiSuGeneraPersecRepa
    PROCEDURE pCarggtbTiSuGenePersecRepa
    IS
    
        csbMetodo       CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pCarggtbTiSuGenePersecRepa'; 
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuTipoSuspGenePers IS
            SELECT REGEXP_SUBSTR(csbTIPO_SUSP_GENE_PERS, '[^' || csbCOMA || ']+', 1, level ) TipoSusp
            FROM dual        
            CONNECT BY regexp_substr(csbTIPO_SUSP_GENE_PERS, '[^' || csbCOMA || ']+', 1, level) is not null;   
    BEGIN
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF gtbTiSuGeneraPersecRepa.COUNT = 0 THEN
        
            FOR rgTiSu IN cuTipoSuspGenePers LOOP
                gtbTiSuGeneraPersecRepa( rgTiSu.TipoSusp  ) := 1;
            END LOOP;
        
        END IF;
            
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
    END pCarggtbTiSuGenePersecRepa;
    
    -- Carga la tabla global gtbPrNoValiAutoreco
    PROCEDURE pCarggtbPrNoValiAutoreco
    ( 
        inuServ         NUMBER, 
        inuProceso      NUMBER
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pCarggtbPrNoValiAutoreco';  
    
        -- Cursor referenciado para obtener los productos a procesar
        rfcProdNoValPers  SYS_REFCURSOR;
        
        TYPE tytbProdNoValPers IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        
        tbProdNoValPers tytbProdNoValPers;
                        
        csbRT                   VARCHAR2(1) := CHR(13);
        
        CURSOR cuConsConf 
        IS
        WITH ActiValid AS
        (
            select DISTINCT REGEXP_SUBSTR( A.ACTIVIDAD_VALIDAR, '[^,]+' , 1, level ) Actividad
            from   LDC_PROCESO A
            where A.PROCESO_ID = inuProceso
            connect by regexp_substr( A.ACTIVIDAD_VALIDAR,'[^,]+', 1, level) is not null  
        ),
        TiTrValid AS
        (
            select DISTINCT task_type_id
            from   or_task_types_items
            where items_id in (  SELECT Actividad FROM ActiValid )
        ),
        EstaNoTerm AS
        (
            SELECT ORDER_STATUS_ID EstaOrde
            FROM or_order_status
            WHERE is_final_status =  'N'		
        ),
        ListaActiValid AS
        (         
            select ListAgg(Actividad,',') within group ( order by 1 ) sbActiValid from    ActiValid
        ),
        ListaTiTrValid AS
        (
            select ListAgg(task_type_id,',') within group ( order by 1 ) sbTiTrValid from    TiTrValid
        ),
        ListaEstaNoTerm AS
        (
            select ListAgg(EstaOrde,',') within group ( order by 1 ) sbEstaNoTerm from    EstaNoTerm
        ),
        ListasEstados AS
        (
            select EstadoProducto sbEstaProd, EstadoCorteCC sbEstaCort
            from   LDC_PROCESO A
            where A.PROCESO_ID = inuProceso            
        )
        SELECT * FROM ListaActiValid, ListaTiTrValid, ListaEstaNoTerm, ListasEstados;
        
        rcConsConf  cuConsConf%ROWTYPE;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
                            
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        IF NOT gblgtbPrNoValiAutoreco THEN
    
            OPEN cuConsConf;
            FETCH cuConsConf INTO rcConsConf;
            CLOSE cuConsConf;
            
            IF rcConsConf.sbEstaProd <> '-1' THEN
            
                gsbConsulta := 'select pr.product_id sesunuse' || csbRT ||
                    'from or_order ot' || csbRT ||
                    'inner join or_order_activity oa on oa.order_id = ot.order_id' || csbRT ||
                    'inner join pr_product pr on pr.product_id = oa.product_id' || csbRT ||
                    'where ot.task_type_id in ( '|| rcConsConf.sbTiTrValid || ' )' || csbRT ||
                    '  and ot.order_status_id in ( ' || rcConsConf.sbEstaNoTerm || ' )' || csbRT ||
                    '  and oa.activity_id + 0 in ('|| rcConsConf.sbActiValid || ' )' || csbRT ||
                    '  and pr.product_status_id + 0 IN ( ' || rcConsConf.sbEstaProd || ')' || csbRT ||
                    '  and pr.product_type_id = :nuServ' || csbRT;
            
            ELSE
            
                gsbConsulta := 'select pr.sesunuse' || csbRT ||
                    'from or_order ot' || csbRT ||
                    'inner join or_order_activity oa on oa.order_id = ot.order_id' || csbRT ||
                    'inner join servsusc pr on pr.sesunuse = oa.product_id' || csbRT ||
                    'where ot.task_type_id in ( '|| rcConsConf.sbTiTrValid || ' )' || csbRT ||
                    '  and ot.order_status_id in ( ' || rcConsConf.sbEstaNoTerm || ' )' || csbRT ||
                    '  and oa.activity_id + 0 in ('|| rcConsConf.sbActiValid || ' )' || csbRT ||
                    '  and pr.sesuesco + 0 IN ( ' || rcConsConf.sbEstaCort || ')' || csbRT ||
                    '  and pr.sesuserv = :nuServ' || csbRT;
                    
            END IF;
            
            PKG_TRAZA.TRACE( 'gsbConsulta|' || gsbConsulta, 10 );
             
            OPEN rfcProdNoValPers FOR gsbConsulta USING inuServ;
            
            LOOP
            
                tbProdNoValPers.DELETE;
                        
                FETCH rfcProdNoValPers BULK COLLECT INTO tbProdNoValPers LIMIT 100;
            
                EXIT WHEN tbProdNoValPers.COUNT = 0;
                
                FOR ind IN 1..tbProdNoValPers.COUNT LOOP
                    gtbPrNoValiAutoreco(tbProdNoValPers(ind)) := 1;
                END LOOP;
                            
            END LOOP;
            
            CLOSE rfcProdNoValPers;
            
            gblgtbPrNoValiAutoreco := TRUE;
            
        END IF;
        
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
    END pCarggtbPrNoValiAutoreco;

    FUNCTION fnuGetActividadgenerarAuto( inuProceso IN LDC_PROCESO.PROCESO_ID%TYPE ,
                                      inuActividad IN LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE,
                                      sbMarca  in number)  RETURN NUMBER IS

        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fnuGetActividadgenerarAuto';  

        --consulta Actividad a Generar
        CURSOR cuConsultaActividadGene IS
        SELECT PROXIMA_ACTIVITY_ID
        FROM LDC_ACTIVIDAD_GENERADA LAG
        WHERE LAG.PROCESO_ID = inuProceso
        AND LAG.ACTIVITY_ID_GENERADA = inuActividad
        AND INSTR(','||SUSPENSION_TYPE_ID||',',','||sbMarca||',') > 0 ;

        nuProxActivi  LDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID%type;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN
 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        OPEN cuConsultaActividadGene;
        FETCH cuConsultaActividadGene INTO nuProxActivi;
        CLOSE cuConsultaActividadGene;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuProxActivi;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN -1;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN -1; 
    END fnuGetActividadgenerarAuto;

    -- Valida si el producto debe iniciar proceso de persecucion por autoreconexion
    FUNCTION fnugetValidaAuto (inuProducto IN servsusc.sesunuse%type, inuProceso ldc_proceso.proceso_id%TYPE) RETURN NUMBER IS

        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fnugetValidaAuto';  

        nugetValidaAuto NUMBER(1) := 0;
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        pCarggtbPrNoValiAutoreco
        ( 
            cnuSERV_GAS         , 
            inuProceso      
        );
                 
        IF gtbPrNoValiAutoreco.exists( inuProducto) THEN
            nugetValidaAuto := 1;
        END IF; 

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nugetValidaAuto;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 0;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 0; 
    END fnugetValidaAuto;

    /**************************************************************************
        Nombre      : fsbPermiteRegistroAutoRec
        Autor       : OLsoftware
        Fecha       : 10-11-2020
        Ticket      : CA452
        Descripcion : Servicio que permite validar si se realiza el registro
                      en LDC_SUSP_AUTORECO

        Parametros Entrada
         inuProducto         Codigo del producto

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        10/11/2020  OLsoftware   CA452. Creacion
		05/06/2023	jpinedc-MVM   OSF-1169: * Refactoring       
    ***************************************************************************/
    FUNCTION fsbPermiteRegistroAutoRec
    (
        inuProducto         IN      pr_product.product_id%type
    )
    RETURN VARCHAR2
    IS
    
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fsbPermiteRegistroAutoRec';  
    
        sbPermiteRegistroAutoRec    VARCHAR2(1) := 'N';
        
        cnuEdadSup          CONSTANT NUMBER := daLDC_PARAREPE.fnuGetPAREVANU('PERSEC_EDAD_SUP',NULL);
        cnuEdadInf          CONSTANT NUMBER := daLDC_PARAREPE.fnuGetPAREVANU('PERSEC_EDAD_INFER',NULL);

        nuEdadProducto      NUMBER;
                
        nuTipoSuspension    PR_PROD_SUSPENSION.suspension_type_id%type;
        
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        
        CURSOR cuTipoSuspension IS
            SELECT SUSPENSION_TYPE_ID
            FROM (
                SELECT *
                FROM PR_PROD_SUSPENSION
                WHERE PRODUCT_ID = inuProducto
                AND ACTIVE = 'Y'
                ORDER BY register_date desc
                )
            WHERE rownum = 1;
    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pCarggtbTiSuGenePersecRepa;        
                
        nuEdadProducto := ldc_getedadrp(inuProducto);
        
        IF nuEdadProducto > cnuEdadSup THEN

            sbPermiteRegistroAutoRec := 'Y';
        
        ELSE
        
            IF nuEdadProducto >= cnuEdadInf AND nuEdadProducto <= cnuEdadSup THEN
            
                OPEN cuTipoSuspension;
                FETCH cuTipoSuspension INTO nuTipoSuspension;
                CLOSE cuTipoSuspension;
                                
                IF gtbTiSuGeneraPersecRepa.exists(nuTipoSuspension)  THEN
                
                    sbPermiteRegistroAutoRec := 'Y';
                
                END IF;

            END IF;            
            
        END IF;
            

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        RETURN sbPermiteRegistroAutoRec;
                
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
    END fsbPermiteRegistroAutoRec;
    
    /**************************************************************************
        Nombre      : GeneraPerscaAuto
        Autor       : OLsoftware
        Fecha       : 05-07-2020
        Ticket      : CA47
        Descripcion : Procesa los registros cuando es automatico

        Parametros Entrada
         inuProceso         Codigo del proceso
         inCiclo            Codigo del ciclo
         inDepartamento     Codigo dl departamento
         inLocalidad        Codigo de la localidad
         inuHilo            Hilo actual
         inuTotalHilos      Total hilos
         inuServ            Tipo de producto
         isbEstaCorte       Estados de corte
         isbProgram         Programa

        Valor de salida
         onuOk              0- Exito, -1 Error
         osbMensaje         Mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        05/07/2020  OLsoftware   CA47. Creacion
        22/11/2020  OLSoftware   CA452. Validacion de edad producto para creación de ordenes
                                 de persecución
								
	    09/12/2020  ljlb          CA 337 se coloca validacion de producto excluido		
        12/05/2021  OLSoftware    CA519: Se modificará los cursores cuConsuLectfact y cuLecturas 
                                  para que no validen que la observación de lectura sea nula 
		03/05/2023	jpinedc-MVM   OSF-1075: Se quita del cursor cuproductossuspendidosauto la ejecución
								  de fnugetValidaAuto. Se cambia el loop FORALL por uno NORMAL
								  para ejecutar fnugetValidaAuto								  
		24/05/2023	jpinedc-MVM   OSF-1075: * Se pasa el cursor de cargos a la nueva función 
								  fsbVolFactMayToler y se quita la instrucción continue
                                  * Se usa fsbVolFactMayToler antes de insertar en 
								  LDC_SUSP_AUTORECO
		02/05/2023	jpinedc-MVM   OSF-1169: * Refactoring fnugetValidaAuto
                                  * Refactoring GeneraPerscaAuto
		21/11/2023	jpinedc-MVM   OSF-1635: * En el proceso de persecución por estado de
                                  producto al comparar el consumo con gnuToleranciaDif 
                                  se cambia de mayor o igual a mayor
    ***************************************************************************/
    PROCEDURE GeneraPerscaAuto
    (
        inuProceso      IN   NUMBER,
        inCiclo         IN   NUMBER,
        inDepartamento  IN   NUMBER,
        inLocalidad     IN   NUMBER,
        inuHilo         IN   NUMBER,
        inuTotalHilos   IN   NUMBER,
        inuServ         IN   NUMBER,
        isbProgram      IN   VARCHAR2,
        isbEstadoCorte  IN   VARCHAR2,
        isbEstadoProd   IN   VARCHAR2,
        isbTipoSuspen   IN   VARCHAR2,
        onuOk           OUT  NUMBER,
        osbMensaje      OUT  VARCHAR2
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.GeneraPerscaAuto';  

    	sbRegistra	    varchar2(1);

        nuDepaProd NUMBER;
        nuLocaProd NUMBER;

        nuTitrSusp NUMBER;
        nuOrdenSusp  NUMBER;
        nuLectSusp  NUMBER;

        SBESTADOCORTE              VARCHAR2(4000);
        SBESTADOPRODUCTO           VARCHAR2(4000);
        SBTIPOSUSPENSION           VARCHAR2(4000);

        nuUltimaLectura number;
        CantiReg     number := 0;
        NUCantiReg     number := 0;

        nuConta      number := 0;
        sumaConsumo  number := 0;
        nuPromedio   number := 0;
        nuDeudaCorr  NUMBER(15, 2) := 0;
        nuDeudaDife  NUMBER(15, 2) := 0;
        nuSaldoTot   NUMBER(15, 2) := 0;
        Limite       number(9);
        sbmarca      varchar(1);
        
        NUACTIVITY     ge_items.items_id%type;
        NUACTIV_GENERA ge_items.items_id%type;
        DFFECHALEGA    date;

        nuTotal    NUMBER := 0;

        --parametros
        nuNumPeriodo          number := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_PERI_EVA_PERS');
        add_cons_tope         number(9) := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PCAR_VALOR_ADIC_CONS_PROM');
        sw                    number;
        periodos_consecutivos VARCHAR2(1) := pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_PERIODO_CONSE_PERS');
        ONUPREVPECSCONS       conssesu.cosspecs%type;
        -- contrato a procesar
        nuNumesusc servsusc.sesususc%type;
        -- Producto a procesar
        nuNumeServ servsusc.sesunuse%type;
        -- Estado de Corte del Producto
        nuServEsco servsusc.sesuesco%type;
        -- Ciclo del producto
        nuciclo servsusc.sesucicl%type;
        -- order_activity_id de la orden de suspension
        -- Ciclo de consumo del servicio suscrito
        nuCicloCons servsusc.sesucico%type;
        
        nuORD_ACT_ID pr_product.SUSPEN_ORD_ACT_ID%type;

        nuLEEMLETO lectelme.LEEMLETO%type;
        nuLEEMPEFA lectelme.LEEMPEFA%type;
        dfLEEMFELE lectelme.LEEMFELE%type;
        nuLEEMSESU lectelme.LEEMSESU%type;
        nuLEEMDOCU lectelme.LEEMDOCU%type;
        nuLEEMPECS lectelme.LEEMPECS%type;
        
        type stylectelme IS record(
            LEEMLETO lectelme.LEEMLETO%type,
            LEEMPEFA lectelme.LEEMPEFA%type,
            LEEMFELE lectelme.LEEMFELE%type,
            LEEMSESU lectelme.LEEMSESU%type,
            LEEMDOCU lectelme.LEEMDOCU%type,
            LEEMPECS lectelme.LEEMPECS%type
        );

        type tbtylectelmeTable IS table of stylectelme index BY binary_integer;

        tblectelme tbtylectelmeTable;

        cursor cuproductossuspendidosauto(nuCiclo          servsusc.sesucicl%type,
                                      NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE,
                                      ESTADOCORTE      VARCHAR2,
                                      ESTADOPRODCUTO   VARCHAR2,
                                      TIPOSSUSPENSION  VARCHAR2,
                                      inudepa  NUMBER,
                                      inuloca NUMBER,
                                      inuProductId IN   servsusc.sesunuse%type)
        IS
            SELECT *
            FROM
            (
            SELECT sesususc,
               sesunuse,
               sesuesco,
               sesucicl,
               suspen_ord_act_id,
               PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
               PKG_BCPRODUCTO.FNUOBTENERLOCALIDAD(s.sesunuse ) LOCA,
               inuHilo pershilo
            FROM servsusc              s,
                 pr_product            p,
                 pr_prod_suspension    ps,
                 ldc_proceso_actividad lpa
            WHERE s.sesuesco IN
                (
                    SELECT TO_NUMBER(REGEXP_SUBSTR(decode(estadocorte,'-1',to_char(s.sesuesco),estadocorte), '[^' || csbCOMA || ']+', 1, level ))
                    FROM dual        
                    CONNECT BY REGEXP_SUBSTR(decode(estadocorte,'-1',to_char(s.sesuesco),estadocorte), '[^' || csbCOMA || ']+', 1, level ) is not null 
                )
             AND p.product_status_id IN
                 
                (
                    SELECT TO_NUMBER(REGEXP_SUBSTR(decode(estadoprodcuto,'-1',to_char(p.product_status_id),estadoprodcuto), '[^' || csbCOMA || ']+', 1, level ))
                    FROM dual        
                    CONNECT BY REGEXP_SUBSTR(decode(estadoprodcuto,'-1',to_char(p.product_status_id),estadoprodcuto), '[^' || csbCOMA || ']+', 1, level ) is not null 
                )
             AND ps.suspension_type_id IN
                (
                    SELECT TO_NUMBER(REGEXP_SUBSTR(decode(tipossuspension,'-1',to_char(ps.suspension_type_id),tipossuspension), '[^' || csbCOMA || ']+', 1, level ))
                    FROM dual        
                    CONNECT BY REGEXP_SUBSTR(decode(tipossuspension,'-1',to_char(ps.suspension_type_id),tipossuspension), '[^' || csbCOMA || ']+', 1, level ) is not null 
                )
             AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
             AND sesuserv = inuServ
             AND ps.ACTIVE ='Y'
             AND p.product_id = s.sesunuse
             AND p.product_id = ps.product_id
             AND p.suspen_ord_act_id IS NOT NULL
             AND 0 = (SELECT count(1)
                        FROM LDC_SUSP_AUTORECO, or_order
                       WHERE SARESESU = sesunuse
                         AND SAREORDE = order_id
                         AND order_status_id IN (0, 5, 6, 7))--200-2614
             AND 0 = (SELECT count(1)
                        FROM LDC_SUSP_AUTORECO
                       WHERE SARESESU = s.sesunuse
                         AND SAREORDE IS NULL)
             AND lpa.proceso_id = nuldc_proceso_id
             AND lpa.activity_id =
                 pkg_bcordenes.fnuObtieneItemActividad(suspen_ord_act_id)
             AND NOT EXISTS(  SELECT 'X'
                              FROM or_order_activity, or_order, ldc_actividad_generada
                              WHERE or_order_activity.product_id = p.product_id
                                 AND or_order_activity.order_id = or_order.order_id
                                 AND order_status_id IN (0, 5, 6, 7) --200-2614
                                 AND or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                 AND ldc_actividad_generada.activity_id_generada = lpa.activity_id -- Inicia NC 3468.
                                )
            AND sesunuse = inuProductId
            AND LDC_PKGESTPREXCLURP.FUNVALEXCLURP(sesunuse) = 0
            )
            WHERE DEPA = DECODE(inuDepa, -1, depa, inudepa)
                AND loca = DECODE(inuLoca, -1, loca, inuLoca)
            ;

        rcproductossuspendidosauto cuproductossuspendidosauto%ROWTYPE ;

        CURSOR cuMaximaLectura(nuNuse           lectelme.leemsesu%type,
                               NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE)
        IS

            SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
            FROM lectelme a
            inner join or_order_activity b
            on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
            WHERE LEEMSESU = nuNuse
            AND LEEMCLEC = 'T'
            AND pkg_BCOrdenes.fnuObtieneTipoTrabajo(b.order_id) =
               (SELECT LPA.TASK_TYPE_ID
                  FROM LDC_PROCESO_ACTIVIDAD LPA
                 WHERE LPA.PROCESO_ID = NULDC_PROCESO_ID
                   AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
           ORDER BY leemfele desc;

        --se consulta informacion del producto
        CURSOR cuDatosProd
        IS
            SELECT daab_segments.fnugetoperating_sector_id(PKG_BCDIRECCIONES.FNUGETSEGMENTO_ID(address_id), NULL) seop,
               suscclie cliente,
               subscription_id contrato,
               product_status_id estado_prod,
               address_id direccion,
               category_id categoria,
               (SELECT multivivienda
               FROM ldc_info_predio
               WHERE premise_id =  PKG_BCDIRECCIONES.FNUGETPREDIO(address_id )
                 AND ROWNUM < 2) multfami,
              ( SELECT MAX(plazo_maximo)
                FROM ldc_plazos_cert
                WHERE id_producto = product_id) plazo_max
            FROM pr_product, suscripc
            WHERE subscription_id = susccodi
            AND product_id = nuNumeServ;
            
        rgDatosProd cuDatosProd%rowtype;

        -- se consulta lectura actual y lectura anterior de facturacion
        CURSOR cuConsuLectfact(dtFechaLect date)
        IS --200-2611
          SELECT leemleto lectactu, leemlean lectant, leemfele fecha
          FROM lectelme
          WHERE leemsesu = nuNumeServ
            AND leemtcon = 1
            AND leemclec = 'F'
        	and lectelme.leemfele>=dtFechaLect --200-2611
            AND lectelme.leemfele IN
               (SELECT MAX(lectelme.leemfele)
                  FROM lectelme
                 WHERE leemsesu = nuNumeServ
                   AND leemclec = 'F')
            AND leemleto > 0;

        rgLecturaProd cuConsuLectfact%rowtype;

        --Se consulta marca de suspension
        CURSOR cuMarcaProd
        IS
            SELECT suspension_type_id
            FROM pr_prod_suspension
            WHERE active = 'Y'
              AND product_id = nuNumeServ;

        nuMarcaProd NUMBER;

        CURSOR cuLecturas(nuNuse lectelme.leemsesu%type,
                          dtfele lectelme.leemfele%type)
        IS
            SELECT LEEMLETO, LEEMPEFA, LEEMFELE, LEEMSESU, LEEMDOCU, LEEMPECS
            FROM lectelme
            WHERE LEEMSESU = nuNuse
            AND leemtcon = 1
            AND LEEMCLEC = 'F'
            AND leemfele > dtfele
            and lectelme.leemfele in
               (SELECT max(lectelme.leemfele)
                  FROM lectelme
                 WHERE leemsesu = nuNuse
                   AND leemclec = 'F')
            and LEEMLETO > 0;

        CURSOR CUEXISTE(NUDATO NUMBER, SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE)
        IS
            SELECT count(1) cantidad
            FROM DUAL
            WHERE NUDATO IN
            (
                SELECT TO_NUMBER(REGEXP_SUBSTR(SBPARAMETRO, '[^' || csbCOMA || ']+', 1, level ))
                FROM dual        
                CONNECT BY regexp_substr(SBPARAMETRO, '[^' || csbCOMA || ']+', 1, level) is not null   
            );

        nuCount NUMBER := 0;
        
        CURSOR cuCantProdProcesar IS
            SELECT count(1)
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;
            
            
        CURSOR cuProdGas
        IS    
            SELECT sesunuse
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;
            
        TYPE tytbProgGas IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
           
        tbProdGas tytbProgGas;
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbInformacion   estaprog.esprinfo%TYPE;              
                       
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        sbInformacion :=    'Proceso=' || inuProceso || 
                            '|Ciclo=' || inCiclo || 
                            '|Departamento=' || inDepartamento ||
                            '|Localidad=' || inLocalidad;
                            
        pkStatusExeProgramMgr.upInfoExeProgram( isbProgram, sbInformacion );
		
        SBESTADOCORTE       := isbEstadoCorte;
        SBESTADOPRODUCTO    := isbEstadoProd;
        SBTIPOSUSPENSION    := isbTipoSuspen;

        nuPaso := 18;          
        
        DELETE FROM LDC_SUSP_AUTORECO LSP
         WHERE LSP.SARECICL = DECODE(inCiclo, -1, LSP.SARECICL, inCiclo)
           AND LSP.SAREDEPA = DECODE(inDepartamento, -1, LSP.SAREDEPA, inDepartamento)
           AND LSP.SARELOCA = DECODE(inLocalidad, -1, LSP.SARELOCA, inLocalidad)
           AND LSP.SAREACOR IN ( SELECT LPA.ACTIVITY_ID
                     FROM LDC_PROCESO_ACTIVIDAD LPA
                     WHERE LPA.PROCESO_ID = inuProceso)
           AND LSP.SARESESU > 0
           AND MOD( LSP.SARESESU ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        nuPaso := 19;   

         DELETE FROM LDC_SUSP_AUTORECO lsp
          WHERE lsp.SARECICL =  decode(inCiclo, -1, lsp.SARECICL, inCiclo)
            AND LSP.SAREDEPA = DECODE(inDepartamento, -1, LSP.SAREDEPA, inDepartamento)
            AND LSP.SARELOCA = DECODE(inLocalidad, -1, LSP.SARELOCA, inLocalidad)
            AND lsp.SAREACOR in
             (select lpa.activity_id
              from ldc_proceso_actividad lpa
               where lpa.proceso_id = inuProceso
               and lpa.activity_id = lsp.SAREACOR
               and lsp.saresesu in
                 (SELECT OOA.Product_Id
                  FROM OR_ORDER_ACTIVITY OOA
                   WHERE OOA.ACTIVITY_ID = lsp.SAREACOR))
            AND LSP.SARESESU > 0
            AND MOD( LSP.SARESESU ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        COMMIT;
        
        OPEN cuCantProdProcesar;
        FETCH cuCantProdProcesar INTO nuTotal;
        CLOSE cuCantProdProcesar;

        nuPaso := 20;   
        
        OPEN cuProdGas;       
        LOOP
            
            tbProdGas.DELETE;
        
            FETCH cuProdGas BULK COLLECT INTO tbProdGas LIMIT 100;
            
            EXIT WHEN tbProdGas.COUNT = 0;
                   
            -- Obtiene el Total de registros a procesar
            nuCount := nuCount + tbProdGas.COUNT;                    
                             
            FOR indPrGa IN 1..tbProdGas.COUNT LOOP
            
                IF fnuGetValidaAuto( tbProdGas(indPrGa), inuProceso ) = 0 THEN

                    pkStatusExeProgramMgr.UpStatusExeProgramAT(isbProgram,
                                                                 'Procesando productos...',
                                                                 nuTotal,
                                                                 nuCount);
                                
                    rcproductossuspendidosauto := NULL;
                    
                    nuPaso := 21; 
                    
                    OPEN cuproductossuspendidosauto( inCiclo,
                                                 inuProceso,
                                                 SBESTADOCORTE,
                                                 SBESTADOPRODUCTO,
                                                 SBTIPOSUSPENSION,
                                                 inDepartamento,
                                                 inLocalidad,
                                                 tbProdGas(indPrGa)
                                                 );
                    
                    FETCH cuproductossuspendidosauto INTO rcproductossuspendidosauto;
                    CLOSE cuproductossuspendidosauto;
                
                    IF rcproductossuspendidosauto.sesunuse IS NOT NULL THEN
                    
                        nuPaso := 22;                     
                                
                        dfFechaLega     :=  NULL;
                        nuUltimaLectura :=  NULL;
                        nuOrdenSusp     :=  NULL;
                        nuTitrSusp      :=  NULL;
                        nuLectSusp      :=  null;
                        numarcaprod     :=  NULL;
                        rgLecturaProd   :=  NULL;

                        -- Obtiene datos del producto a procesar
                        nuNumesusc   := rcproductossuspendidosauto.sesususc;
                        nuNumeServ   := rcproductossuspendidosauto.sesunuse;
                        nuServEsco   := rcproductossuspendidosauto.sesuesco;
                        nuciclo      := rcproductossuspendidosauto.sesucicl;
                        nuORD_ACT_ID := rcproductossuspendidosauto.SUSPEN_ORD_ACT_ID;
                        nuDepaProd   := rcproductossuspendidosauto.depa;
                        nuLocaProd   := rcproductossuspendidosauto.loca;
                        nuCicloCons  := rcproductossuspendidosauto.sesucicl;

                        nuConta     := 0;
                        sumaConsumo := 0;
                        sw          := 0;

                        -- busca la fecha de lectura
                        open cuMaximaLectura(nuNumeServ, inuProceso);
                        fetch cuMaximaLectura  into dfFechaLega, nuUltimaLectura,   nuOrdenSusp, nuTitrSusp ;
                        close cuMaximaLectura;
                    
                        PKG_TRAZA.TRACE ('dfFechaLega|' || dfFechaLega, 10);
                        PKG_TRAZA.TRACE ('nuUltimaLectura|' || nuUltimaLectura, 10);
                        PKG_TRAZA.TRACE ('nuOrdenSusp|' || nuOrdenSusp, 10);
                        PKG_TRAZA.TRACE ('nuTitrSusp|' || nuOrdenSusp, 10);

                        nuPaso := 23; 
                                            
                        --si es autoreconectado se realiza e cargue de los demas datos
                        nuLectSusp := nuUltimaLectura;

                        OPEN cuDatosProd;
                        FETCH cuDatosProd INTO rgdatosProd;
                        CLOSE cuDatosProd;

                        OPEN cuConsuLectfact(dfFechaLega); --200-2611
                        FETCH cuConsuLectfact INTO rgLecturaProd;
                        CLOSE cuConsuLectfact;

                        OPEN cuMarcaProd;
                        FETCH cuMarcaProd INTO numarcaprod;
                        CLOSE cuMarcaProd;

                        nuPaso := 24; 
                                        
                        PKG_TRAZA.TRACE ('numarcaprod|' || numarcaprod, 10);
                        PKG_TRAZA.TRACE ('dfFechaLega|' || dfFechaLega, 10);
                        PKG_TRAZA.TRACE ('SBESTADOCORTE|' || SBESTADOCORTE, 10);
                        PKG_TRAZA.TRACE ('SBESTADOPRODUCTO|' || SBESTADOPRODUCTO, 10);				

                        --PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA
                        if dfFechaLega is not null AND SBESTADOCORTE <> '-1' then
                      
                            -- Abre el CURSOR de lecturas y recupera los registros
                            open cuLecturas(nuNumeServ, dfFechaLega);
                            fetch cuLecturas bulk collect INTO tblectelme;
                            close cuLecturas;

                            if tblectelme.first > 0 then

                                for k in tblectelme.first .. tblectelme.last loop
                                
                                    -- Obtiene datos de lecturas a procesar
                                    nuLEEMLETO := tblectelme(k).LEEMLETO;
                                    nuLEEMPEFA := tblectelme(k).LEEMPEFA;
                                    dfLEEMFELE := tblectelme(k).LEEMFELE;
                                    nuLEEMSESU := tblectelme(k).LEEMSESU;
                                    nuLEEMDOCU := tblectelme(k).LEEMDOCU;
                                    nuLEEMPECS := tblectelme(k).LEEMPECS;

                                    if sw = 0 then
                                      -- busca el periodo de consumo anterior al primer consumo despues de la suspension
                                      GETPREVCONSPERIOD(nuLEEMPECS, ONUPREVPECSCONS);
                                      -- busca el consumo promedio del periodo anterior al primer periodo de consumo despues de suspendido
                                      nuPromedio := CM_BOHicoprpm.fnuGetLastConsbyProd(nuLEEMSESU,
                                                                                       1,
                                                                                       ONUPREVPECSCONS); -- promedio de consumo del producto del periodo anterior
                                      Limite     := nuPromedio + add_cons_tope;
                                      sw         := 1;
                                    end if;

                                    if ((nuLEEMLETO - nuUltimaLectura) > 0) then
                                      nuConta         := nuConta + 1;
                                      sumaConsumo     := sumaConsumo +
                                                         (nuleemleto - nuUltimaLectura); --rcConsuLec.cosscoca;
                                      nuUltimaLectura := nuleemleto;
                                    else
                                      --Inicio CASO 200-216
                                      --Validacion de gasera

                                        if periodos_consecutivos = 'Y' then
                                          nuConta     := 0;
                                          sumaConsumo := 0;
                                        end if;
                                         --Fin CASO 200-216
                                    end if;
                                    
                                    EXIT WHEN(nuConta >= nuNumPeriodo);

                                end loop;

                                if (nuConta >= nuNumPeriodo) AND  SBESTADOCORTE IS NOT NULL then

                                    --Inicio CASO 200-216
                                    --Validacion de gasera
                                    
                                    --sb200216 := '1. FALSE';
                                    --Validacion Original de EFIGAS
                                    if (sumaConsumo > limite) then
                                        sbmarca := 'S';
                                    else
                                        sbmarca := 'N';
                                    end if;
                                    --Validacion Original de EFIGAS
                                  

                                    nuActivity  := pkg_bcordenes.fnuObtieneItemActividad(nuORD_ACT_ID);
                                    nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                                    nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                                    nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                                    NUACTIV_GENERA := NULL;
                                    NUACTIV_GENERA := fnuGetActividadgenerarAuto(inuProceso, nuActivity, numarcaprod);

                                    IF nvl(NUACTIV_GENERA,0) > 0 THEN

                                        IF  INSTR( ',' || csbPROCAUTORECO_SN || ',' , ',' || inuProceso || ',' ) > 0
                                        OR
                                        fsbPermiteRegistroAutoRec(nuNumeServ) = 'Y' THEN
                        
                                            IF LDC_PKGENEORDEAUTORECO.fsbVolFactMayToler( nuNumeServ, nuServEsCo, dfFechaLega, nuCicloCons ) IN ('S','X') THEN
                                                                                    
                                                insert into LDC_SUSP_AUTORECO
                                                (SARECODI,
                                                 SARESESU,
                                                  SARESAPE,
                                                  SARECONS,
                                                  SAREACTI,
                                                  SAREACOR,
                                                  SAREPEVA,
                                                  SAREAURE,
                                                  SAREFEGE,
                                                  SAREUSER,
                                                  SAREFEPR,
                                                  SAREORDE,
                                                  SARECICL,
                                                  SAREDEPA,
                                                  SARELOCA,
                                                  SARESECT,
                                                  SARECLIE,
                                                  SARECONT,
                                                  SAREESPR,
                                                  SAREDIRE,
                                                  SARECATE,
                                                  SAREMULT,
                                                  SAREPLMA,
                                                  SARELEAC,
                                                  SARELEAN,
                                                  SARELESU,
                                                  SAREFESU,
                                                  SARETTSU,
                                                  SAREORSU,
                                                  SAREMARC,
                                                  SAREPROC
                                                  )
                                              values
                                                (SEQ_LDC_SUSP_AUTORECO.nextval,
                                                 nuNumeServ,
                                                 nuSaldoTot,
                                                nuLectSusp - nvl(rgLecturaProd.lectactu,0)  /*sumaConsumo*/,
                                                 NUACTIV_GENERA,
                                                 nuActivity,
                                                 nuConta,
                                                 sbmarca,
                                                 null,
                                                 null,
                                                 trunc(sysdate),
                                                 null,
                                                 nuciclo,
                                                 nuDepaProd,
                                                 nuLocaProd,
                                                 rgDatosProd.seop,
                                                 rgDatosProd.cliente,
                                                 rgDatosProd.contrato,
                                                 rgDatosProd.estado_prod,
                                                 rgDatosProd.direccion,
                                                 rgDatosProd.categoria,
                                                 rgDatosProd.multfami,
                                                 rgDatosProd.plazo_max,
                                                 rgLecturaProd.lectactu,
                                                 rgLecturaProd.lectant,
                                                 nuLectSusp,
                                                 dfFechaLega,
                                                 nuTitrSusp,
                                                 nuOrdenSusp,
                                                 numarcaprod,
                                                 inuProceso
                                                  );

                                                NUCantiReg := NUCantiReg + 1;
                                                
                                            END IF;
                            
                                        END IF;

                                    end if;

                                    IF MOD(NUCantiReg, 1000) = 0 THEN
                                       CantiReg := CantiReg + NUCantiReg  ;
                                       NUCantiReg := 0;
                                       commit;
                                    END IF;

                                end if; -- (nuConta >= nuNumPeriodo)
                      
                            end if; --tblectelme.first > 0

                        --PRESECUSION PARA LOS SERVICIOS CON EL ESTADO DEL PRODCUTO
                        ELSif dfFechaLega is not null AND SBESTADOPRODUCTO <> '-1' then

                            nuPaso := 25; 
                        
                            --sb200216 :=  '2. FALSE';
                            --Validacion Original de EFIGAS
                            if (nuUltimaLectura > add_cons_tope) then
                                sbmarca := 'N';
                            else
                                sbmarca := 'S';
                            end if;

                            PKG_TRAZA.TRACE ('nuLectSusp|' || nuLectSusp, 10);
                            PKG_TRAZA.TRACE ('rgLecturaProd.lectactu|' || rgLecturaProd.lectactu, 10);
                            PKG_TRAZA.TRACE ('gnuToleranciaDif|' || gnuToleranciaDif, 10);

                            if abs(nuLectSusp - rgLecturaProd.lectactu   )> gnuToleranciaDif AND rgLecturaProd.lectactu IS NOT NULL THEN
                                sbRegistra:='S';
                            else
                                sbRegistra:='N';
                            end if;


                            nuActivity  := pkg_bcordenes.fnuObtieneItemActividad(nuORD_ACT_ID);
                            nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                            nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                            nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                            nuPaso := 26;
                            
                            NUACTIV_GENERA := NULL;
                            NUACTIV_GENERA := fnuGetActividadgenerarAuto(inuProceso, nuActivity, numarcaprod);
                    
                            PKG_TRAZA.TRACE ('NUACTIV_GENERA|' || NUACTIV_GENERA, 10);
                            PKG_TRAZA.TRACE ('sbRegistra|' || sbRegistra, 10);				

                            IF nvl(NUACTIV_GENERA,0) > 0 THEN

                                IF sbRegistra = 'S' THEN --200-2611
                              
                                    IF INSTR( ',' || csbPROCAUTORECO_SN || ',' , ',' || inuProceso || ',' ) > 0
                                    OR
                                    fsbPermiteRegistroAutoRec(nuNumeServ) = 'Y' THEN

                                        IF LDC_PKGENEORDEAUTORECO.fsbVolFactMayToler( nuNumeServ, nuServEsCo, dfFechaLega, nuCicloCons ) IN ( 'S','X' ) THEN
                                            
                                            nuPaso := 27;
                                                                        
                                            insert into LDC_SUSP_AUTORECO
                                            (SARECODI,
                                             SARESESU,
                                              SARESAPE,
                                              SARECONS,
                                              SAREACTI,
                                              SAREACOR,
                                              SAREPEVA,
                                              SAREAURE,
                                              SAREFEGE,
                                              SAREUSER,
                                              SAREFEPR,
                                              SAREORDE,
                                              SARECICL,
                                              SAREDEPA,
                                              SARELOCA,
                                              SARESECT,
                                              SARECLIE,
                                              SARECONT,
                                              SAREESPR,
                                              SAREDIRE,
                                              SARECATE,
                                              SAREMULT,
                                              SAREPLMA,
                                              SARELEAC,
                                              SARELEAN,
                                              SARELESU,
                                              SAREFESU,
                                              SARETTSU,
                                              SAREORSU,
                                              SAREMARC,
                                              SAREPROC
                                              )
                                          values
                                            (SEQ_LDC_SUSP_AUTORECO.nextval,
                                             nuNumeServ,
                                             nuSaldoTot,
                                             nvl(rgLecturaProd.lectactu,0) - nuLectSusp,--sumaConsumo,
                                             NUACTIV_GENERA,
                                             nuActivity,
                                             nuConta,
                                             sbmarca,
                                             null,
                                             null,
                                             trunc(sysdate),
                                             null,
                                             nuciclo,
                                             nuDepaProd,
                                             nuLocaProd,
                                             rgDatosProd.seop,
                                             rgDatosProd.cliente,
                                             rgDatosProd.contrato,
                                             rgDatosProd.estado_prod,
                                             rgDatosProd.direccion,
                                             rgDatosProd.categoria,
                                             rgDatosProd.multfami,
                                             rgDatosProd.plazo_max,
                                             rgLecturaProd.lectactu,
                                             rgLecturaProd.lectant,
                                             nuLectSusp,
                                             dfFechaLega,
                                             nuTitrSusp,
                                             nuOrdenSusp,
                                             numarcaprod,
                                             inuProceso
                                              );
                                              
                                            NUCantiReg := NUCantiReg + 1;
                                        
                                        END IF;

                                    END IF;
                        
                                END IF;--200-2611
                    
                            end if; -- nvl(NUACTIV_GENERA,0) > 0

                            IF MOD(NUCantiReg, 1000) = 0 THEN
                                CantiReg := CantiReg + NUCantiReg;
                                NUCantiReg := 0;
                                commit;
                            END IF;
                       
                        END IF; -- FIN PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA

                    END IF; -- fin for
                
                END IF;
            
            END LOOP;

            COMMIT;
            CantiReg := CantiReg + NUCantiReg;
            NUCantiReg := 0;
            
        END LOOP;
        
        CLOSE cuProdGas;
        
        nuPaso := 28;        
        
        -- Actualiza el estaprog en el campo estasufa, para indicar la cantidad de usuarios a persecucion
        UPDATE estaprog SET esprsufa = CantiReg WHERE esprprog = isbProgram;
        commit;

        nuPaso := 29;    

        onuOk := 1;

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
    END GeneraPerscaAuto;
 
 
    /**************************************************************************
        Nombre      : GeneraPerscaNoAuto
        Autor       : OLsoftware
        Fecha       : 05-07-2020
        Ticket      : CA47
        Descripcion : Procesa los registros cuando no es automatico

        Parametros Entrada
         inuProceso         Codigo del proceso
         inCiclo            Codigo del ciclo
         inDepartamento     Codigo dl departamento
         inLocalidad        Codigo de la localidad
         inuHilo            Hilo actual
         inuTotalHilos      Total hilos
         inuServ            Tipo de producto
         isbEstaCorte       Estados de corte
         isbProgram         Programa

        Valor de salida
         onuOk              0- Exito, -1 Error
         osbMensaje         Mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        05/07/2020  OLsoftware   CA47. Creacion
    ***************************************************************************/
    PROCEDURE GeneraPerscaNoAuto
    (
        inuProceso      IN   NUMBER,
        inCiclo         IN   NUMBER,
        inDepartamento  IN   NUMBER,
        inLocalidad     IN   NUMBER,
        inuHilo         IN   NUMBER,
        inuTotalHilos   IN   NUMBER,
        inuServ         IN   NUMBER,
        isbProgram      IN   VARCHAR2,
        isbEstadoCorte  IN   VARCHAR2,
        isbEstadoProd   IN   VARCHAR2,
        isbTipoSuspen   IN   VARCHAR2,
        onuOk           OUT  NUMBER,
        osbMensaje      OUT  VARCHAR2
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.GeneraPerscaNoAuto';
        
    	sbRegistra	    varchar2(1);

        nuDepaProd NUMBER;
        nuLocaProd NUMBER;

        nuTitrSusp NUMBER;
        nuOrdenSusp  NUMBER;
        nuLectSusp  NUMBER;

        SBESTADOCORTE              VARCHAR2(4000);
        SBESTADOPRODUCTO           VARCHAR2(4000);
        SBTIPOSUSPENSION           VARCHAR2(4000);

        nuUltimaLectura number;
        CantiReg     number := 0;
        NUCantiReg     number := 0;

        nuConta      number := 0;
        sumaConsumo  number := 0;
        nuPromedio   number := 0;
        nuDeudaCorr  NUMBER(15, 2) := 0;
        nuDeudaDife  NUMBER(15, 2) := 0;
        nuSaldoTot   NUMBER(15, 2) := 0;
        Limite       number(9);
        sbmarca      varchar(1);

        NUACTIVITY     ge_items.items_id%type;
        NUACTIV_GENERA ge_items.items_id%type;
        DFFECHALEGA    date;

        nuTotal    NUMBER := 0;
 
        nuNumPeriodo          number := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_PERI_EVA_PERS');
        add_cons_tope         number(9) := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PCAR_VALOR_ADIC_CONS_PROM');
        sw                    number;
        periodos_consecutivos VARCHAR2(1) := pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_PERIODO_CONSE_PERS');
        ONUPREVPECSCONS       conssesu.cosspecs%type;
        -- contrato a procesar
        nuNumesusc servsusc.sesususc%type;
        -- Producto a procesar
        nuNumeServ servsusc.sesunuse%type;
        -- Estado de Corte del Producto
        nuServEsco servsusc.sesuesco%type;
        -- Ciclo del producto
        nuciclo servsusc.sesucicl%type;
        -- order_activity_id de la orden de suspension
        nuORD_ACT_ID pr_product.SUSPEN_ORD_ACT_ID%type;

        nuLEEMLETO lectelme.LEEMLETO%type;
        nuLEEMPEFA lectelme.LEEMPEFA%type;
        dfLEEMFELE lectelme.LEEMFELE%type;
        nuLEEMSESU lectelme.LEEMSESU%type;
        nuLEEMDOCU lectelme.LEEMDOCU%type;
        nuLEEMPECS lectelme.LEEMPECS%type;

        type styServsusc IS record(
            sesususc          servsusc.sesususc%type,
            sesunuse          servsusc.sesunuse%type,
            sesuesco          servsusc.sesuesco%type,
            sesucicl          servsusc.sesucicl%type,
            SUSPEN_ORD_ACT_ID pr_product.SUSPEN_ORD_ACT_ID%type,
            sesudepa          number(6),
            sesuloca          number(6),
            PERSHILO          LDC_PRODGENEPER.pershilo%TYPE
        );

        type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

        tbServsusc tbtyServsuscTable;

        type stylectelme IS record(
            LEEMLETO lectelme.LEEMLETO%type,
            LEEMPEFA lectelme.LEEMPEFA%type,
            LEEMFELE lectelme.LEEMFELE%type,
            LEEMSESU lectelme.LEEMSESU%type,
            LEEMDOCU lectelme.LEEMDOCU%type,
            LEEMPECS lectelme.LEEMPECS%type
        );

        type tbtylectelmeTable IS table of stylectelme index BY binary_integer;

        tblectelme tbtylectelmeTable;

        cursor cuproductossuspendidos(nuCiclo          servsusc.sesucicl%type,
                                      NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE,
                                      ESTADOCORTE      VARCHAR2,
                                      ESTADOPRODCUTO   VARCHAR2,
                                      TIPOSSUSPENSION  VARCHAR2,
                                      inudepa  NUMBER,
                                      inuloca NUMBER,
                                      inuProductId     IN servsusc.sesunuse%type)
        IS
            SELECT *
            FROM (
                SELECT sesususc,
                   sesunuse,
                   sesuesco,
                   sesucicl,
                   suspen_ord_act_id,
                   PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
                   PKG_BCPRODUCTO.FNUOBTENERLOCALIDAD(s.sesunuse ) LOCA,
                   inuHilo pershilo
                FROM servsusc              s,
                     pr_product            p,
                     pr_prod_suspension    ps,
                     ldc_proceso_actividad lpa
                WHERE s.sesuesco IN
                    (
                        SELECT TO_NUMBER(REGEXP_SUBSTR(decode(estadocorte,'-1',to_char(s.sesuesco),estadocorte), '[^' || csbCOMA || ']+', 1, level ))
                        FROM dual        
                        CONNECT BY regexp_substr(decode(estadocorte,'-1',to_char(s.sesuesco),estadocorte), '[^' || csbCOMA || ']+', 1, level) is not null 
                    )
                 AND p.product_status_id IN
                    (
                        SELECT TO_NUMBER(REGEXP_SUBSTR(decode(estadoprodcuto,'-1',to_char(p.product_status_id),estadoprodcuto), '[^' || csbCOMA || ']+', 1, level ))
                        FROM dual        
                        CONNECT BY regexp_substr(decode(estadoprodcuto,'-1',to_char(p.product_status_id),estadoprodcuto), '[^' || csbCOMA || ']+', 1, level) is not null 
                    )
                 AND ps.suspension_type_id IN
                    (
                        SELECT TO_NUMBER(REGEXP_SUBSTR(decode(tipossuspension,'-1',to_char(ps.suspension_type_id),tipossuspension), '[^' || csbCOMA || ']+', 1, level ))
                        FROM dual        
                        CONNECT BY regexp_substr(decode(tipossuspension,'-1',to_char(ps.suspension_type_id),tipossuspension), '[^' || csbCOMA || ']+', 1, level) is not null 
                    )
                 AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
                 AND sesuserv = inuServ
                 and ps.ACTIVE ='Y'
                 AND p.product_id = s.sesunuse
                 AND p.product_id = ps.product_id
                 AND p.suspen_ord_act_id IS NOT NULL
                 AND 0 = (SELECT count(1)
                            FROM ldc_susp_persecucion, or_order
                           WHERE susp_persec_producto = sesunuse
                             AND susp_persec_order_id = order_id
                             AND order_status_id IN (0, 5, 7)) --200-2614
                 AND 0 = (SELECT count(1)
                            FROM ldc_susp_persecucion
                           WHERE susp_persec_producto = s.sesunuse
                             AND susp_persec_order_id IS NULL)
                 AND lpa.proceso_id = nuldc_proceso_id
                 AND lpa.activity_id =
                     pkg_bcordenes.fnuObtieneItemActividad(suspen_ord_act_id)
                 AND NOT EXISTS(  SELECT 'X'
                                  FROM or_order_activity, or_order, ldc_actividad_generada
                                  WHERE or_order_activity.product_id = p.product_id
                                     AND or_order_activity.order_id = or_order.order_id
                                     AND order_status_id IN (0, 5, 7) --200-2614
                                     AND or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                       AND ldc_actividad_generada.activity_id_generada = lpa.activity_id -- Inicia NC 3468.
                                    )
                AND sesunuse = inuProductId

              ) WHERE DEPA = DECODE(inuDepa, -1, depa, inudepa)
                AND loca = DECODE(inuLoca, -1, loca, inuLoca);

        TYPE tbUsuarioPers IS TABLE OF cuproductossuspendidos%ROWTYPE  ;
        v_tbUsuarioPers tbUsuarioPers;

        CURSOR cuConsUsuaProc
        IS
            SELECT *
            FROM LDC_PRODGENEPER
            WHERE pershilo = inuHilo;

        CURSOR cuMaximaLectura(nuNuse           lectelme.leemsesu%type,
                               NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE)
        IS
            SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
            FROM lectelme a
            inner join or_order_activity b
            on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
            WHERE LEEMSESU = nuNuse
            AND LEEMCLEC = 'T'
            AND pkg_BCOrdenes.fnuObtieneTipoTrabajo( b.ORDER_ID) =
               (SELECT LPA.TASK_TYPE_ID
                  FROM LDC_PROCESO_ACTIVIDAD LPA
                 WHERE LPA.PROCESO_ID = NULDC_PROCESO_ID
                   AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
           ORDER BY leemfele desc;


        CURSOR cuLecturas(nuNuse lectelme.leemsesu%type,
                          dtfele lectelme.leemfele%type)
        IS
            SELECT LEEMLETO, LEEMPEFA, LEEMFELE, LEEMSESU, LEEMDOCU, LEEMPECS
            FROM lectelme
            WHERE LEEMSESU = nuNuse
            AND leemtcon = 1
            AND LEEMCLEC = 'F'
            AND leemfele > dtfele
            and lectelme.leemfele in
               (SELECT max(lectelme.leemfele)
                  FROM lectelme
                 WHERE leemsesu = nuNuse
                   AND leemclec = 'F')
            --Inicio CASO 200-216
            and (lectelme.LEEMOBLE =-1 or LEEMOBLE IS NULL)
            and LEEMLETO > 0;
            --Fin CASO 200-216

        --CURSOR PARA LA PROXIMA ACTIVIDAD A GENERAR
        CURSOR CULDC_ACTIVIDAD_GENERADA
        (
            NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE,
            NUACTIVITY_ID    LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE)
        IS
            SELECT LAG.*
            FROM LDC_ACTIVIDAD_GENERADA LAG
            WHERE LAG.PROCESO_ID = NULDC_PROCESO_ID
            AND LAG.ACTIVITY_ID_GENERADA = NUACTIVITY_ID;

        TEMPLDC_ACTIVIDAD_GENERADA CULDC_ACTIVIDAD_GENERADA%ROWTYPE;

        CURSOR CUEXISTE(NUDATO NUMBER, SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE)
        IS
            SELECT count(1) cantidad
            FROM DUAL
            WHERE NUDATO IN
            (
                SELECT TO_NUMBER(REGEXP_SUBSTR(SBPARAMETRO, '[^' || csbCOMA || ']+', 1, level ))
                FROM dual        
                CONNECT BY regexp_substr(SBPARAMETRO, '[^' || csbCOMA || ']+', 1, level) is not null 
            );

        ---curosr para determinar si el producto ya esta registrado
        cursor culdc_susp_persecucion
        (
            nususp_persec_producto ldc_susp_persecucion.susp_persec_producto %TYPE
        )
        is
            select count(1)
            from ldc_susp_persecucion lsp
            where lsp.susp_persec_producto = nususp_persec_producto;

        nuculdc_susp_persecucion number := 0;
        nuCount         number := 0;
        
        CURSOR cuObtieneProductosGas IS
            SELECT SESUNUSE
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        nuProductId     servsusc.sesunuse%type;
        
        CURSOR cuCantProdProcesar IS
            SELECT count(1)
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;
            
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbInformacion   estaprog.esprinfo%TYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        sbInformacion :=    'Proceso=' || inuProceso || 
                            '|Ciclo=' || inCiclo || 
                            '|Departamento=' || inDepartamento ||
                            '|Localidad=' || inLocalidad;
                            
        pkStatusExeProgramMgr.upInfoExeProgram( isbProgram, sbInformacion );        
        
        SBESTADOCORTE       := isbEstadoCorte;
        SBESTADOPRODUCTO    := isbEstadoProd;
        SBTIPOSUSPENSION    := isbTipoSuspen;

        --se eliminan registros
        DELETE FROM LDC_SUSP_PERSECUCION LSP
         WHERE LSP.SUSP_PERSEC_CICLCODI = DECODE(inCiclo, -1, LSP.SUSP_PERSEC_CICLCODI, inCiclo)
           AND LSP.SUSP_PERSEC_DEPA = DECODE(inDepartamento, -1, LSP.SUSP_PERSEC_DEPA, inDepartamento)
           AND LSP.SUSP_PERSEC_LOCA = DECODE(inLocalidad, -1, LSP.SUSP_PERSEC_LOCA, inLocalidad)
           AND LSP.SUSP_PERSEC_ACT_ORIG IN ( SELECT LPA.ACTIVITY_ID
                               FROM LDC_PROCESO_ACTIVIDAD LPA
                              WHERE LPA.PROCESO_ID = inuProceso)
           AND LSP.SUSP_PERSEC_PRODUCTO > 0
           AND MOD( LSP.SUSP_PERSEC_PRODUCTO ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        DELETE FROM LDC_SUSP_PERSECUCION lsp
         WHERE lsp.susp_persec_ciclcodi =  decode(inCiclo, -1, lsp.susp_persec_ciclcodi, inCiclo)
           AND LSP.SUSP_PERSEC_DEPA = DECODE(inDepartamento, -1, LSP.SUSP_PERSEC_DEPA, inDepartamento)
           AND LSP.SUSP_PERSEC_LOCA = DECODE(inLocalidad, -1, LSP.SUSP_PERSEC_LOCA, inLocalidad)
           and lsp.susp_persec_act_orig in
             (select lpa.activity_id
              from ldc_proceso_actividad lpa
               where lpa.proceso_id = inuProceso
               and lpa.activity_id = lsp.susp_persec_act_orig
               and lsp.susp_persec_producto in
                 (SELECT OOA.Product_Id
                  FROM OR_ORDER_ACTIVITY OOA
                   WHERE OOA.ACTIVITY_ID = lsp.susp_persec_act_orig))
           AND LSP.SUSP_PERSEC_PRODUCTO > 0
           AND MOD( LSP.SUSP_PERSEC_PRODUCTO ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        COMMIT;

        --se consultas datos para hacer persecucion y se llena tabla de sesion
        
        OPEN cuObtieneProductosGas;
        LOOP
        FETCH cuObtieneProductosGas INTO nuProductId;
        EXIT WHEN cuObtieneProductosGas%NOTFOUND;
        
            OPEN cuproductossuspendidos( inCiclo,
                                     inuProceso,
                                     SBESTADOCORTE,
                                     SBESTADOPRODUCTO,
                                     SBTIPOSUSPENSION,
                                     inDepartamento,
                                     inLocalidad,
                                     nuProductId );
            LOOP
              FETCH cuproductossuspendidos BULK COLLECT INTO v_tbUsuarioPers LIMIT 100;
                FORALL i IN 1..v_tbUsuarioPers.COUNT
                    INSERT INTO LDC_PRODGENEPER  VALUES v_tbUsuarioPers(i);
              EXIT WHEN cuproductossuspendidos%NOTFOUND;
            END LOOP;
            CLOSE cuproductossuspendidos;
            

        END LOOP;
        CLOSE cuObtieneProductosGas;

        -- Abre el CURSOR de productos y recupera los registros
            OPEN cuConsUsuaProc;
            LOOP
            FETCH cuConsUsuaProc BULK COLLECT INTO tbServsusc LIMIT 100;
            -- Obtiene el Total de registros a procesar

            nuTotal := nuTotal + tbServsusc.COUNT;
            
            FOR i IN 1..tbServsusc.COUNT LOOP

                nuCount := nuCount + 1;

                -- Actualiza el estado del proceso en ESTAPROG
                pkStatusExeProgramMgr.UpStatusExeProgramAT(isbProgram,
                                                           'Procesando productos...',
                                                            nuTotal,
                                                            nuCount);
                dfFechaLega := NULL;
                nuUltimaLectura := NULL;
                nuOrdenSusp := NULL;
                nuTitrSusp := NULL;
                nuLectSusp := null;

                -- Obtiene datos del producto a procesar
                nuNumesusc   := tbServsusc(i).sesususc;
                nuNumeServ   := tbServsusc(i).sesunuse;
                nuServEsco   := tbServsusc(i).sesuesco;
                nuciclo      := tbServsusc(i).sesucicl;
                nuORD_ACT_ID := tbServsusc(i).SUSPEN_ORD_ACT_ID;
                nuDepaProd   := tbServsusc(i).sesudepa;
                nuLocaProd   := tbServsusc(i).sesuloca;

                nuConta     := 0;
                sumaConsumo := 0;
                sw          := 0;

                IF cuMaximaLectura%ISOPEN THEN
                    CLOSE  cuMaximaLectura;
                END IF;

                -- busca la fecha de lectura
                open cuMaximaLectura(nuNumeServ, inuProceso);
                fetch cuMaximaLectura  into dfFechaLega, nuUltimaLectura,   nuOrdenSusp, nuTitrSusp ;
                if cuMaximaLectura%notfound then
                    dfFechaLega := null;
                end if;
                close cuMaximaLectura;

              --PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA
              if dfFechaLega is not null AND SBESTADOCORTE <> '-1' then
                -- Abre el CURSOR de lecturas y recupera los registros
                open cuLecturas(nuNumeServ, dfFechaLega);
                fetch cuLecturas bulk collect INTO tblectelme;
                close cuLecturas;

                if tblectelme.first > 0 then
                  --for Consu in cuPerico(rg.sesunuse, dfFechaLega) loop
                  for k in tblectelme.first .. tblectelme.last loop
                    -- Obtiene datos de lecturas a procesar
                    nuLEEMLETO := tblectelme(k).LEEMLETO;
                    nuLEEMPEFA := tblectelme(k).LEEMPEFA;
                    dfLEEMFELE := tblectelme(k).LEEMFELE;
                    nuLEEMSESU := tblectelme(k).LEEMSESU;
                    nuLEEMDOCU := tblectelme(k).LEEMDOCU;
                    nuLEEMPECS := tblectelme(k).LEEMPECS;
                    --for Consu in cuLecturas(nuNumeServ, dfFechaLega) loop
                    if sw = 0 then
                      -- busca el periodo de consumo anterior al primer consumo despues de la suspension
                      GETPREVCONSPERIOD(nuLEEMPECS, ONUPREVPECSCONS);
                      -- busca el consumo promedio del periodo anterior al primer periodo de consumo despues de suspendido
                      nuPromedio := CM_BOHicoprpm.fnuGetLastConsbyProd(nuLEEMSESU,
                                                                       1,
                                                                       ONUPREVPECSCONS); -- promedio de consumo del producto del periodo anterior
                      Limite     := nuPromedio + add_cons_tope;
                      sw         := 1;
                    end if;

                    if ((nuLEEMLETO - nuUltimaLectura) > 0) then
                      nuConta         := nuConta + 1;
                      sumaConsumo     := sumaConsumo +
                                         (nuleemleto - nuUltimaLectura); --rcConsuLec.cosscoca;
                      nuUltimaLectura := nuleemleto;
                    else

                        if periodos_consecutivos = 'Y' then
                          nuConta     := 0;
                          sumaConsumo := 0;
                        end if;

                    end if; -- ((nuLEEMLETO - nuUltimaLectura) > 0)

                    EXIT WHEN(nuConta >= nuNumPeriodo);

                  end loop;
                  
                  if (nuConta >= nuNumPeriodo) AND  SBESTADOCORTE IS NOT NULL then

                    --Validacion Original de EFIGAS
                    if (sumaConsumo > limite) then
                        sbmarca := 'S';
                    else
                        sbmarca := 'N';
                    end if;                    

                    nuActivity  := pkg_bcordenes.fnuObtieneItemActividad(nuORD_ACT_ID);
                    nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                    nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                    nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                    NUACTIV_GENERA := NULL;


                    OPEN CULDC_ACTIVIDAD_GENERADA(inuProceso, nuActivity);
                    FETCH CULDC_ACTIVIDAD_GENERADA
                    INTO TEMPLDC_ACTIVIDAD_GENERADA;

                    IF CULDC_ACTIVIDAD_GENERADA%FOUND THEN
                        NUACTIV_GENERA := TEMPLDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID;
                    END IF;
                    CLOSE CULDC_ACTIVIDAD_GENERADA;


                   IF nvl(NUACTIV_GENERA,0) > 0 THEN
                   --se valida si es autoreconectado
                    open culdc_susp_persecucion(nuNumeServ);
                    fetch culdc_susp_persecucion
                      into nuculdc_susp_persecucion;
                    close culdc_susp_persecucion;

                        if nuculdc_susp_persecucion = 0 then

                        insert into LDC_SUSP_PERSECUCION
                          (SUSP_PERSEC_CODI,
                           SUSP_PERSEC_PRODUCTO,
                           SUSP_PERSEC_SALPEND,
                           SUSP_PERSEC_CONSUMO,
                           SUSP_PERSEC_ACTIVID,
                           SUSP_PERSEC_ACT_ORIG,
                           SUSP_PERSEC_PERVARI,
                           SUSP_PERSEC_PERSEC,
                           SUSP_PERSEC_FEGEOT,
                           SUSP_PERSEC_USER_ID,
                           SUSP_PERSEC_FEJPROC,
                           SUSP_PERSEC_ORDER_ID,
                           SUSP_PERSEC_CICLCODI,
                           SUSP_PERSEC_DEPA,
                           SUSP_PERSEC_LOCA)
                        values
                          (SEQ_LDC_SUSP_PERSECUCION.nextval,
                           nuNumeServ,
                           nuSaldoTot,
                           sumaConsumo,
                           NUACTIV_GENERA,
                           nuActivity,
                           nuConta,
                           sbmarca,
                           null,
                           null,
                           trunc(sysdate),
                           null,
                           nuciclo,
                           nuDepaProd,
                           nuLocaProd);
                           
                           NUCantiReg := NUCantiReg + 1;
                           
                        END IF;

                   end if; -- nvl(NUACTIV_GENERA,0) > 0

                    IF MOD(NUCantiReg, 1000) = 0 THEN
                       CantiReg := CantiReg + NUCantiReg  ;
                       NUCantiReg := 0;
                       commit;
                    END IF;

                  end if; -- (nuConta >= nuNumPeriodo)
                end if; --tblectelme.first > 0

              --PRESECUSION PARA LOS SERVICIOS CON EL ESTADO DEL PRODCUTO
              ELSif dfFechaLega is not null AND SBESTADOPRODUCTO <> '-1' then
                
                  --Validacion Original de EFIGAS
                  if (nuUltimaLectura > add_cons_tope) then
                    sbmarca := 'N';
                  else
                    sbmarca := 'S';
                  end if;


                --200-2611--------------------
                sbRegistra :='S';
                --200-2611--------------------

                nuActivity  := pkg_bcordenes.fnuObtieneItemActividad(nuORD_ACT_ID);
                nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                NUACTIV_GENERA := NULL;

                OPEN CULDC_ACTIVIDAD_GENERADA(inuProceso, nuActivity);
                FETCH CULDC_ACTIVIDAD_GENERADA
                INTO TEMPLDC_ACTIVIDAD_GENERADA;
                IF CULDC_ACTIVIDAD_GENERADA%FOUND THEN
                   NUACTIV_GENERA := TEMPLDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID;
                END IF;
                CLOSE CULDC_ACTIVIDAD_GENERADA;

                IF nvl(NUACTIV_GENERA,0) > 0 THEN
                  open culdc_susp_persecucion(nuNumeServ);
                  fetch culdc_susp_persecucion
                    into nuculdc_susp_persecucion;
                  close culdc_susp_persecucion;

                  if nuculdc_susp_persecucion = 0 then
                   --se valida si es autoreconectado
                      insert into LDC_SUSP_PERSECUCION
                        (SUSP_PERSEC_CODI,
                         SUSP_PERSEC_PRODUCTO,
                         SUSP_PERSEC_SALPEND,
                         SUSP_PERSEC_CONSUMO,
                         SUSP_PERSEC_ACTIVID,
                         SUSP_PERSEC_ACT_ORIG,
                         SUSP_PERSEC_PERVARI,
                         SUSP_PERSEC_PERSEC,
                         SUSP_PERSEC_FEGEOT,
                         SUSP_PERSEC_USER_ID,
                         SUSP_PERSEC_FEJPROC,
                         SUSP_PERSEC_ORDER_ID,
                         SUSP_PERSEC_CICLCODI,
                         SUSP_PERSEC_DEPA,
                         SUSP_PERSEC_LOCA)
                      values
                        (SEQ_LDC_SUSP_PERSECUCION.nextval,
                         nuNumeServ,
                         nuSaldoTot,
                         sumaConsumo,
                         NUACTIV_GENERA,
                         nuActivity,
                         nuConta,
                         sbmarca,
                         null,
                         null,
                         trunc(sysdate),
                         null,
                         nuciclo,
                         nuDepaProd,
                         nulocaProd);
                        
                        NUCantiReg := NUCantiReg + 1;
                         
                    END IF;
                
                end if;  -- nvl(NUACTIV_GENERA,0) > 0

                IF MOD(NUCantiReg, 1000) = 0 THEN
                 CantiReg := CantiReg + NUCantiReg;
                 NUCantiReg := 0;
                 commit;
                END IF;
              END IF; -- FIN PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA

            END LOOP; -- fin for
        COMMIT;
        CantiReg := CantiReg + NUCantiReg;
        NUCantiReg := 0;

        EXIT WHEN cuConsUsuaProc%NOTFOUND;
        END LOOP;
        CLOSE cuConsUsuaProc;
        
        -- Actualiza el estaprog en el campo estasufa, para indicar la cantidad de usuarios a persecucion
        UPDATE estaprog SET esprsufa = CantiReg WHERE esprprog = isbProgram;
        commit;

        onuOk := 1;
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
    END GeneraPerscaNoAuto;

    PROCEDURE progeneraPersca( isbProgram      IN  VARCHAR2,
                            inuProceso      IN  NUMBER,
                            inuCICLO        IN  NUMBER,
                            inuDepartamento IN  NUMBER,
                            inuLocalidad    IN  NUMBER,
                            inuHilo         IN  NUMBER,
                            inuTotalHilos   IN  NUMBER) IS
   /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar persecuon

        Parametros Entrada
         inuProceso    codigo del proceso
         sbCICLO     codigo del ciclo
         sbDepartamento   departamento
         sbLocalidad     localidad
        Valor de salida
        onuOk        0- Exito, -1 Error
        osbMensaje     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR                      DESCRIPCION
        02/05/2019   dsaltarin                  caso 200-2614 Se realizan correcciones al proceso,
                                                para que solo registre los autoreconectados que
                                                tengan diferencia de lectura        
        21/08/2019  Mateo Velez / OLSOFTWARE    modificacion del cursor cuValidaOrde para la
                                                mejora de tiempos de respuesta y validacion 
                                                de actividades, porque anteriormente validaba
                                                por tipos de trabajos.
        05/07/2020  OLsoftware.CA47             Se ajusta para serparar la lógica cuando se haga
                                                llamado si es un proceso automatico o no.
                                                Se crea «GeneraPerscaAuto» y «GeneraPerscaNoAuto»
        22/11/2020  OLsoftware.CA452            Se realiza validacion en el proceso GeneraPerscaAuto
                                                para determinar si se genera la orden de persecucion        
        05/07/2020  OLsoftware                  Se ajusta para serparar la lógica cuando se haga
                                                llamado si es un proceso automatico o no.
   ***************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.progeneraPersca';
        
    inCiclo             NUMBER;
    inDepartamento      NUMBER;
    inLocalidad         NUMBER;
    
    onuOk   number;
    osbMensaje varchar2(2000);
    nuServ       LD_PARAMETER.numeric_value%TYPE;
    CantiReg     number := 0;

    nuTotal    NUMBER := 0;
    sbProgram  VARCHAR2(2000);
    Const_CERO NUMBER := 0;
    
    --parametros
    nuNumPeriodo          number;
    nuActivi_suspe_pers   ge_items.items_id%type;
    nuActivi_corte_pers   ge_items.items_id%type;
    nuSaldo_param         NUMBER(15, 2) := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SALDO_TOTAL_PERS');
    add_cons_tope         number(9);
    nuActivi_corte        ge_items.items_id%type;

    periodos_consecutivos VARCHAR2(1);

    type styServsusc IS record(
    sesususc          servsusc.sesususc%type,
    sesunuse          servsusc.sesunuse%type,
    sesuesco          servsusc.sesuesco%type,
    sesucicl          servsusc.sesucicl%type,
    SUSPEN_ORD_ACT_ID pr_product.SUSPEN_ORD_ACT_ID%type,
    sesudepa          number(6),
    sesuloca          number(6)
    );

    type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

    type stylectelme IS record(
    LEEMLETO lectelme.LEEMLETO%type,
    LEEMPEFA lectelme.LEEMPEFA%type,
    LEEMFELE lectelme.LEEMFELE%type,
    LEEMSESU lectelme.LEEMSESU%type,
    LEEMDOCU lectelme.LEEMDOCU%type,
    LEEMPECS lectelme.LEEMPECS%type
    );

    sbSubject       VARCHAR2(2000);
    sbMessage0      VARCHAR2(4000);

    --CURSOR PARA OBTENER LOS DATOS PRO PROCESO DE PERSECUCION
    CURSOR culdc_Proceso(NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE) IS
    SELECT LP.* FROM LDC_PROCESO LP WHERE LP.PROCESO_ID = NULDC_PROCESO_ID;
    
    rcldc_Proceso          culdc_Proceso%ROWTYPE;     

    --CURSOR PARA LA PROXIMA ACTIVIDAD A GENERAR
    CURSOR CULDC_ACTIVIDAD_GENERADA(NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE,
                                    NUACTIVITY_ID    LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE) IS
    SELECT LAG.*
    FROM LDC_ACTIVIDAD_GENERADA LAG
    WHERE LAG.PROCESO_ID = NULDC_PROCESO_ID
    AND LAG.ACTIVITY_ID_GENERADA = NUACTIVITY_ID;

    ---curosr para determinar si el producto ya esta registrado
    cursor culdc_susp_persecucion(nususp_persec_producto ldc_susp_persecucion.susp_persec_producto %TYPE) is
    select count(1)
    from ldc_susp_persecucion lsp
    where lsp.susp_persec_producto = nususp_persec_producto;
    
    SBESTADOCORTE              VARCHAR2(4000);
    SBESTADOPRODUCTO           VARCHAR2(4000);
    SBTIPOSUSPENSION           VARCHAR2(4000);

    --Inicio CASO 200-216
    NUPCAR_TOPE_FACT_SUSP ld_parameter.numeric_value%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PCAR_TOPE_FACT_SUSP');
    
    nuError                     NUMBER;
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
                         
    gnuToleranciaDif := CASE inuProceso 
							WHEN cnuLDC_PROCAUTORECO THEN
                                cnuTOLEREANCIA_DIF
                            ELSE
                                cnuTOLEREANCIA_DIFSN
                            END;
    nuPaso := 0;

    inCiclo         := nvl(inuCICLO,-1);
    inDepartamento  := nvl(inuDepartamento,-1);
    inLocalidad     := nvl(inuLocalidad,-1);

    nuPaso := 1;

    OPEN culdc_Proceso(inuProceso);
    FETCH culdc_Proceso INTO rcldc_Proceso;
    CLOSE culdc_Proceso;
    
    sbRecipients := rcldc_Proceso.EMAIL;

    -- Inicializa contador de productos procesados
    CantiReg := 0;
    nuTotal  := 0;

    sbProgram := TRIM(isbProgram);

    nuPaso := 2;
    
    -- Establece Ejecutable
    pkg_Error.setapplication('PERSCA');

    nuPaso := 3;
    
    -- Obtiene consecutivo de proceso para Estaprog  ESTAPROG.ESPRPROG%TYPE
    sbProgram := sbProgram || '-' ||inuHilo;

    nuPaso := 4;
    
    -- Inicializa registro en Estaprog
    -- Valida que exista un registro con el correspondiente key,
    -- si no existe lo crea en la tabla ESTAPROG
    pkStatusExeProgramMgr.ValidateRecordAT(sbProgram);

    -- Inicializa el estado del proceso en ESTAPROG
    pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                             'Inicio proceso Persecucion de suspendidos - PERSCA',
                                             nuTotal,
                                             Const_CERO);

    nuSERV := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_TIPO_SERV');

    nuPaso := 5;

    if nuSERV is null then
        sbMessage0 := 'No existe datos para el parametro "COD_TIPO_SERV", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;
    
    nuPaso := 6;    

    nuNumPeriodo := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_PERI_EVA_PERS');

    if nuNumPeriodo is null then
        sbMessage0 := 'No existe datos para el parametro "NUM_PERI_EVA_PERS", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 7;   
    
    nuActivi_suspe_pers := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ITEM_SUSP_PERS');

    if nuActivi_suspe_pers is null then
        sbMessage0 := 'No existe datos para el parametro "ID_ITEM_SUSP_PERS", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 8;  
    
    nuActivi_corte_pers := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ITEM_CORTE_PERS');

    if nuActivi_corte_pers is null then
        sbMessage0 := 'No existe datos para el parametro "ID_ITEM_CORTE_PERS", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 9;  
    
    nuSaldo_param := pkg_BCLD_Parameter.fnuObtieneValorNumerico('SALDO_TOTAL_PERS');

    if nuSaldo_param is null then
        sbMessage0 := 'No existe datos para el parametro "SALDO_TOTAL_PERS", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 10;  

    add_cons_tope := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PCAR_VALOR_ADIC_CONS_PROM');

    if add_cons_tope is null then
        sbMessage0 := 'No existe datos para el parametro "PCAR_VALOR_ADIC_CONS_PROM", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 11;  
    
    --Inicio CASO 200-216
    if NUPCAR_TOPE_FACT_SUSP is null then
        sbMessage0 := 'No existe datos para el parametro "NUPCAR_TOPE_FACT_SUSP", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;
    --Fin CASO 200-216

    nuPaso := 12;  

    nuActivi_corte := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ITEM_CORTE_MORA');

    if nuActivi_corte is null then
        sbMessage0 := 'No existe datos para el parametro "ID_ITEM_CORTE_MORA", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 13;  
    
    periodos_consecutivos := pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_PERIODO_CONSE_PERS');

    if periodos_consecutivos is null then
        sbMessage0 := 'No existe datos para el parametro "FLAG_PERIODO_CONSE_PERS", Favor crearlo por el comando LDPAR' ||
                      chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                      chr(10);
        RAISE pkg_Error.CONTROLLED_ERROR;
    end if;

    nuPaso := 14;  
    
    IF rcldc_Proceso.ESTADOCORTE IS NOT NULL THEN
        SBESTADOCORTE := rcldc_Proceso.ESTADOCORTE;
    ELSE
        SBESTADOCORTE := '-1';
    END IF;
    
    nuPaso := 15;      

    IF rcldc_Proceso.ESTADOPRODUCTO IS NOT NULL THEN
        SBESTADOPRODUCTO := rcldc_Proceso.ESTADOPRODUCTO;
    ELSE
        SBESTADOPRODUCTO := '-1';
    END IF;

    nuPaso := 16;      

    IF (rcldc_Proceso.SUSPENSION_TYPES IS NOT NULL) THEN
        SBTIPOSUSPENSION := rcldc_Proceso.SUSPENSION_TYPES;
    ELSE
        SBTIPOSUSPENSION := '-1';
    END IF;

    nuPaso := 17;  
    
    -- Se hace el llamado a los servicio nuevos
    --se valida si el proceso es autoreconetado
    IF INSTR( ',' || cnuLDC_PROCAUTORECO ||  ',' || csbPROCAUTORECO_SN || ',' , ',' || inuProceso || ',' ) = 0
    THEN
        GeneraPerscaNoAuto
        (
            inuProceso,
            inCiclo,
            inDepartamento,
            inLocalidad,
            inuHilo,
            inuTotalHilos,
            nuSERV,
            sbProgram,
            SBESTADOCORTE,
            SBESTADOPRODUCTO,
            SBTIPOSUSPENSION,
            onuOk,
            osbMensaje
    );
    ELSE
        GeneraPerscaAuto
        (
            inuProceso,
            inCiclo,
            inDepartamento,
            inLocalidad,
            inuHilo,
            inuTotalHilos,
            nuSERV,
            sbProgram,
            SBESTADOCORTE,
            SBESTADOPRODUCTO,
            SBTIPOSUSPENSION,
            onuOk,
            osbMensaje
        );
    END IF;

    -- Actualiza el estado del proceso en ESTAPROG                                             
    pkStatusExeProgramMgr.ProcessFinishOK(sbProgram);
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
EXCEPTION
  WHEN pkg_Error.CONTROLLED_ERROR then
    pkg_Error.getError( nuError, sbMessage0 );
    -- Actualiza el estado del proceso en ESTAPROG
    pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                               'Proceso Finalizado con Errores: ' ||
                                               sbMessage0,
                                               nuTotal,
                                               nuTotal);

    sbSubject := 'ERROR PERSCA - PROCESO DE PERSECUCION DE USUARIOS SUSPENDIDOS QUE TIENEN VARIACION DE LECTURA   ' || 'nuPaso=' || nuPaso || ' ' ||
                 SYSDATE;

    pkg_Correo.prcEnviaCorreo( sbRecipients, sbSubject, sbMessage0);

    rollback;
    RAISE pkg_Error.CONTROLLED_ERROR;
  when OTHERS then
    pkg_Error.setError;
    pkg_Error.getError( nuError, sbMessage0 );  
    -- Actualiza el estado del proceso en ESTAPROG
    pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                               'Proceso Finalizado con Errores: ' ||
                                               sbMessage0,
                                               nuTotal,
                                               nuTotal);
    sbSubject  := 'ERROR PERSCA - PROCESO DE PERSECUCION DE USUARIOS SUSPENDIDOS QUE TIENEN VARIACION DE LECTURA   ' || 'nuPaso=' || nuPaso || ' ' ||
                  SYSDATE;
    sbMessage0 := 'Durante la ejecucion del proceso se presento un error no controlado ' ||
                  chr(10) || '[' || SQLCODE || ' - ' || SQLERRM || chr(10) ||
                  ']. Por favor contacte al Administrador.' || chr(10) || ' ' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10);
                  
    pkg_Correo.prcEnviaCorreo( sbRecipients, sbSubject, sbMessage0);

    rollback;
    RAISE pkg_Error.CONTROLLED_ERROR;
 END progeneraPersca;
 
    /**************************************************************************
        Autor       : Olsoftware
        Fecha       : 12-07-2020
        Ticket      : CA47
        Descripcion : Valida si el proceso ya terminó

        Parametros Entrada
         isbIdPrograma          Identificador del programa
         inuCantHilos           Cantidad de hilos

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR                       DESCRIPCION
        05/07/2020  OLsoftware.CA47              Creacion
   ***************************************************************************/
    PROCEDURE VerificaFinProceso
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        inuCantHilos    IN   NUMBER,
        onuCantRegist   OUT  NUMBER,
        onuCantPerse    OUT  NUMBER
    )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.VerificaFinProceso';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuTotales
        IS
            SELECT  SUM(esprsupr) cantRegist,
                    SUM(esprsufa) cantPers
            FROM  estaprog
            WHERE esprprog LIKE isbIdPrograma || '-%'
              AND esprporc >= 100;

        --  Variable para almacenar indicador de finalizaci¿n de proceso
        blProcesoTermino      BOOLEAN;
        
        FUNCTION fblProcesoTermino
        (
            isbIdPrograma   IN   estaprog.esprprog%TYPE,
            inuCantHilos    IN   NUMBER
        )
        RETURN BOOLEAN
        IS
            --  Variable que almacena el numero de procesos pendientes de procesar
            nuProcesosTerm NUMBER;
            
            blProcesoTermino    BOOLEAN := TRUE;
            
            CURSOR cuEstaProg
            IS
            SELECT COUNT(1)
            FROM estaprog
            WHERE esprprog LIKE isbIdPrograma || '-%'
            AND esprporc >= 100;            
            
        BEGIN
            pkg_traza.trace(csbMetodo|| '.fblProcesoTermino', csbNivelTraza, pkg_traza.csbINICIO);

            OPEN cuEstaProg;
            FETCH cuEstaProg INTO nuProcesosTerm;
            CLOSE cuEstaProg;

            IF(nuProcesosTerm < inuCantHilos)THEN
              blProcesoTermino := FALSE;
            END IF;
            
            pkg_traza.trace(csbMetodo|| '.fblProcesoTermino', csbNivelTraza, pkg_traza.csbFIN);
            
            RETURN(blProcesoTermino);

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo|| '.fblProcesoTermino', csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);        
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo|| '.fblProcesoTermino', csbNivelTraza, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
        END fblProcesoTermino;
                
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        --  Define que el proceso no termin¿
        blProcesoTermino      := FALSE;
        LOOP

          --  Verifica en la tabla ESTAPROG si el proceso ya termino
          blProcesoTermino   := fblProcesoTermino(isbIdPrograma,inuCantHilos);

          EXIT WHEN blProcesoTermino;

          --  Define un tiempo de espera de 60 segundos para volver a validar
          DBMS_LOCK.SLEEP(60);
        END LOOP;
        
        -- Se calculan los totales procesados
        OPEN cuTotales;
        FETCH cuTotales INTO onuCantRegist, onuCantPerse;
        CLOSE cuTotales;

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
    END VerificaFinProceso;
    
    /**************************************************************************
        Autor       : jpinedc - MVM
        Fecha       : 19/02/2024
        Ticket      : OSF-2341
        Descripcion : Obtiene los totales del proceso

        Parametros Entrada
         isbIdPrograma          Identificador del programa
         inuCantHilos           Cantidad de hilos

        HISTORIA DE MODIFICACIONES
        FECHA       AUTOR                       DESCRIPCION
        19/02/2024  jpinedc                     Creacion
   ***************************************************************************/
    PROCEDURE prcTotales
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        onuCantRegist   OUT  NUMBER,
        onuCantPerse    OUT  NUMBER
    )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.prcTotales';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuTotales
        IS
            SELECT  SUM(esprsupr) cantRegist,
                    SUM(esprsufa) cantPers
            FROM  estaprog
            WHERE esprprog LIKE isbIdPrograma || '-%'
              AND esprporc >= 100;

                
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
       
        -- Se calculan los totales procesados
        OPEN cuTotales;
        FETCH cuTotales INTO onuCantRegist, onuCantPerse;
        CLOSE cuTotales;

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
    END prcTotales;    

    PROCEDURE PROGENEACTAUTORECO(inuConsecutivo IN  LDC_SUSP_AUTORECO.SARECODI%TYPE) IS
    /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar orden de autoreconectado

        Parametros Entrada
         inuProceso    codigo del proceso
         sbCICLO     codigo del ciclo
         sbDepartamento   departamento
         sbLocalidad     localidad
        Valor de salida
        onuOk        0- Exito, -1 Error
        osbMensaje     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.PROGENEACTAUTORECO';
               
        NUORDER_ID              or_order.order_id%type;
        NUACTIV_GENERA          ge_items.items_id%type;

        onuerrorcode               NUMBER;
        osberrormessage            VARCHAR2 (2000);

        ionuorderid              OR_ORDER.ORDER_ID%TYPE;
        ionuOrderactivityid      OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
        nuProduct_id             LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type;
        nuaddressid              pr_product.address_id%type;

        nuSUBSCRIBER_ID          OR_ORDER_ACTIVITY.SUBSCRIBER_ID%type;
        nuSUBSCRIPTION_ID        OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%type;
        nuOrdenGen               number := 0;
        nuOrdenesAct             number := 0;
        nuProEjecucion           number := 0;
        sbSQL                    varchar2(2000);
        sbSQLAct                 varchar2(2000);
        sbSQLEje                 varchar2(2000);
       
        --se consultan datos del producto
        CURSOR cuGeneraOrden IS
        SELECT SAREACTI, SARESESU, SAREORSU, SAREDIRE, SARECLIE, SARECONT, SAREMARC, SAREACOR, SAREPROC
        FROM LDC_SUSP_AUTORECO
        WHERE inuConsecutivo = SARECODI ;

        nuMarcaReport NUMBER;
        nuActividad  NUMBER;
        nuProceso    NUMBER;

        --Se consulta marca de suspension
        CURSOR cuMarcaProd IS
        SELECT suspension_type_id
        FROM pr_prod_suspension
        WHERE active = 'Y'
        AND product_id = nuProduct_id;

        nuMarcaProd NUMBER;
        nuError       NUMBER;
        sbError       VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        --se carga informacion base
        OPEN cuGeneraOrden;
        FETCH cuGeneraOrden INTO NUACTIV_GENERA, nuProduct_id, nuOrder_id, nuaddressid, nuSUBSCRIBER_ID,  nuSUBSCRIPTION_ID, nuMarcaReport, nuActividad, nuProceso;
        CLOSE cuGeneraOrden;

        --se consulta marca actual del producto
        OPEN cuMarcaProd;
        FETCH cuMarcaProd INTO nuMarcaProd;
        CLOSE cuMarcaProd;

        --se valida si el producto cambio la marca
        IF nuMarcaProd IS NOT NULL AND nuMarcaProd <> nuMarcaReport THEN
            NUACTIV_GENERA :=  fnuGetActividadgenerarAuto( nuProceso,
                                          nuActividad,
                                          nuMarcaProd);
        END IF;

        ionuorderid := NULL;

        BEGIN

            nuProEjecucion := 0;
            sbSQLEje := 'select count(1) from GE_CONTROL_PROCESS PRO, ge_record_process RC
                        where PRO.object_id=121471
                        and PRO.record_initial_date > to_date(trunc(sysdate), ''DD/MM/YYYY hh24:mi:ss'')
                        and PRO.advance < 100
                        and PRO.control_process_id = RC.control_process_id
                        and RC.arguments like ''CONSECUTIVO=>'||to_char(inuConsecutivo)||'''';

            EXECUTE IMMEDIATE sbSQLEje INTO nuProEjecucion;

        EXCEPTION
            when no_data_found then
                nuProEjecucion := 0;
        END;

        -- Si no existe el mismo registro procesandose anteriormente
        IF (nuProEjecucion < 2) THEN
            ------------------------------------------------------------------------
            -- Se consulta si el registro que se esta procesando ya contienen una orden generada
            BEGIN

                nuOrdenGen := 0;
                sbSQL:=     'select SAREORDE
                                from LDC_SUSP_AUTORECO
                                where SARECODI= '||inuConsecutivo||
                                ' and SAREORDE is not null and rownum=1';

                EXECUTE IMMEDIATE sbSQL INTO nuOrdenGen;


            EXCEPTION
                when no_data_found then
                    nuOrdenGen := 0;
            END;

            ------------------------------------------------------------------------
            -- Se consulta si existen otras ordenes en estado Asignada o Registrada
            BEGIN

                nuOrdenesAct := 0;

                sbSQLAct := 'select count(1)
                            from LDC_SUSP_AUTORECO
                            where SARECODI ='|| inuConsecutivo||
                            ' and SAREORDE is null
                            and exists   (select ''X''
                                          from or_order_activity, or_order , LDC_ACTIVIDAD_GENERADA
                                          where or_order_activity.product_id = SARESESU
                                            and or_order_activity.order_id = or_order.order_id
                                            and order_status_id in (0,5)
                                            and or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                            and LDC_ACTIVIDAD_GENERADA.activity_id_generada = SAREACOR)';

               EXECUTE IMMEDIATE sbSQLAct INTO nuOrdenesAct;

            EXCEPTION
                when no_data_found then
                    nuOrdenesAct := 0;
            END;

            ------------------------------------------------------------------------

            -- Si no se ha generado una orden previamente en la tabla LDC_SUSP_PERSECUCION
            -- y si no existe una orden de persecucion en estado registrada o asignada
            IF (nuOrdenGen = 0 ) and (nuOrdenesAct=0) and  fnugetValidaAuto(nuProduct_id, nuProceso ) = 0 THEN
                
                api_createorder
                (    
                    inuItemsid          =>  NUACTIV_GENERA,
                    inuPackageid        =>  NULL,
                    inuMotiveid         =>  NULL,
                    inuComponentid      =>  NULL,
                    inuInstanceid       =>  NULL,                    
                    inuAddressid        =>  nuaddressid, 
                    inuElementid        =>  NULL,
                    inuSubscriberid     =>  nuSUBSCRIBER_ID,
                    inuSubscriptionid   =>  nuSUBSCRIPTION_ID,
                    inuProductid        =>  nuPRODUCT_ID,
                    inuOperunitid       =>  NULL,
                    idtExecestimdate    =>  sysdate+1,
                    inuProcessid        =>  NULL,                    
                    isbComment          =>  'ORDEN GENERADA DESDE GOPC',
                    iblProcessorder     =>  TRUE,
                    inuRefvalue         =>  0,
                    ionuOrderid         =>  ionuorderid,
                    ionuOrderactivityid =>  ionuOrderactivityid,
                    onuErrorCode        =>  onuerrorcode,
                    osbErrorMessage     =>  osberrormessage
                );                
                
                IF (onuerrorcode <> 0) THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osberrormessage );
                END IF;

                UPDATE LDC_SUSP_AUTORECO set SAREFEGE = sysdate,
                                             SAREUSER = PKG_SESSION.GETUSERID,
                                             SAREORDE = ionuorderid
                WHERE sarecodi = inuConsecutivo;
                commit;

            -- Inicia NC 3468
            -- Si ya existe una orden en la tabla LDC_SUSP_PERSECUCION
            ELSIF (nuOrdenGen>0) THEN

                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'Error generando Orden al consecutivo ['||inuConsecutivo|| ']'||
                                   ' dado que ya tiene la orden ['||nuOrdenGen||'] generada ';
                pkg_error.setErrorMessage( isbMsgErrr => osbErrorMessage );

            -- Si ya existe una orden registrada o asignada previamente
            ELSIF (nuOrdenesAct>0) THEN

                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'Error generando Orden al consecutivo ['||inuConsecutivo|| ']'||
                                   ' dado que el producto ya tiene una orden en estado asignada o registrada';
                pkg_error.setErrorMessage( isbMsgErrr => osbErrorMessage );               
            END IF;

        ELSE
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Error generando Orden al consecutivo ['||inuConsecutivo|| ']'||
                                   ' por que existe '||nuProEjecucion||' registro en ejecucion ';
            pkg_error.setErrorMessage( isbMsgErrr => osbErrorMessage );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            ROLLBACK;
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            ROLLBACK;
            RAISE pkg_error.Controlled_Error;
    END PROGENEACTAUTORECO;

    PROCEDURE LDC_PROGENTRAMVSI IS
     /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar venta de servicio de ingenieria

        Parametros Entrada
         inuConsecutivo consecutivo de perseuacion
        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA         AUTOR                 DESCRIPCION
        31/05/2019    Miguel Ballesteros    CA 200-2680 Se cambia la forma de como obtener el punto de atencion actual
                                            por medio de un procedimiento que retorna dicho valor y comentando el cursor
                                            que realizaba esta función.
   ***************************************************************************/
   
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.LDC_PROGENTRAMVSI';

        onuErrorCode          NUMBER;
        nuorden             number := null;

        sbRequestXML VARCHAR2(4000);
        nuPackageId  NUMBER;
        nuMotiveId   NUMBER;

        sbmensa      VARCHAR2(10000);
        sbTitrSuspCm   VARCHAR2(4000) :=pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TITRSUSPCMRP');
        sbTitrSuspAcom   VARCHAR2(4000) :=pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TITRSUSPACORP');

        nuActiSuspCm   NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_ACTISUSCMRP');
        nuActiSuspAco  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_ACTISUSACONCERT');

        nuCausSuspCm  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CAUSLEGASUCMRP');
        nuCausSuspAco  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CAUSLEGASUACORP');

        sbItemSuspCm   VARCHAR2(4000) :=pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_ITEMADICISUCMRP');
        sbItemSuspAcom   VARCHAR2(4000) :=pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_ITEMADICISUACORP');

        nuMedioRecepcion  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_MEDIORECEPVSI');
        nuPersonIdsol NUMBER := PKG_BOPERSONAL.FNUGETPERSONAID;

        inuContactIdsol  NUMBER;
        inuIdAddress   NUMBER;
        sbObserva      VARCHAR2(4000);
        nuProductId   NUMBER;
        nuPtoAtncndsol number;

        nuActividad  number;
        nupakageid  NUMBER;
        nuContrato  NUMBER;

        --//---------------- CA 200-2680 ---------------------//-- 
        /* se agrega variable que se encarga de guarda el valor que devuelve 
        el procedimiento para obtener el punto de atencion actual del usuario*/
        ONUCHANNEL   CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE; 

        --se consulta datos del producto
        CURSOR cuDatosProdu IS
        SELECT oa.product_id, OA.ADDRESS_ID,OA.SUBSCRIBER_ID, PACKAGE_ID, OA.SUBSCRIPTION_ID
        FROM or_order_activity oa
        WHERE oa.order_id=nuorden;

        --se valida ultima actividad de suspension
        CURSOR cuUltiActSusp IS
        SELECT o.task_type_id
        from PR_PRODUCT pr, or_order_activity oa, or_order o
        where pr.product_id = nuProductId
         and o.order_id = oa.order_id
         and oa.ORDER_ACTIVITY_ID = pr.suspen_ord_act_id;

        nuTitrSusp number;

        -- Actividad a generar
        CURSOR cuActividadGene IS
        SELECT nuActiSuspCm, nuCausSuspCm, sbItemSuspCm
        FROM dual
        where nuTitrSusp in 
        (
            SELECT TO_NUMBER(REGEXP_SUBSTR(sbTitrSuspCm, '[^' || csbCOMA || ']+', 1, level ))
            FROM dual        
            CONNECT BY regexp_substr(sbTitrSuspCm, '[^' || csbCOMA || ']+', 1, level) is not null 
        )
        UNION ALL
        SELECT nuActiSuspAco, nuCausSuspAco, sbItemSuspAcom
        FROM dual
        where nuTitrSusp in 
        (
            SELECT TO_NUMBER(REGEXP_SUBSTR(sbTitrSuspAcom, '[^' || csbCOMA || ']+', 1, level ))
            FROM dual        
            CONNECT BY regexp_substr(sbTitrSuspAcom, '[^' || csbCOMA || ']+', 1, level) is not null 
        )
            
        ;
        nuCausalLeg  NUMBER;
        sbItemAdic VARCHAR2(4000);

        nuUnidad NUMBER;

        sbproceso  VARCHAR2(100) := 'LDC_PROGENTRAMVSI' ||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);

    BEGIN
 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
         
        -- Inicializamos el proceso
        PKG_ESTAPROC.PRINSERTAESTAPROC(sbproceso,1);
        
        --Obtener el identificador de la orden  que se encuentra en la instancia   
        nuorden       := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;
        
        --se cargan datos de la orden
        OPEN cuDatosProdu;
        FETCH cuDatosProdu INTO nuProductId, inuIdAddress, inuContactIdsol, nupakageid, nuContrato;
        CLOSE cuDatosProdu;
    
        --se consulta punto de atencion con el nuevo procedimiento  
        ONUCHANNEL := PKG_BOPERSONAL.FNUGETPUNTOATENCIONID( nuPersonIdsol );
        nuPtoAtncndsol := ONUCHANNEL;   
 
        --se consulta ultima actividad de suspension
        OPEN cuUltiActSusp;
        FETCH cuUltiActSusp INTO nuTitrSusp;
        CLOSE cuUltiActSusp;
        
        --se consuta actividad a generar
        OPEN cuActividadGene;
        FETCH cuActividadGene INTO nuActividad, nuCausalLeg, sbItemAdic;
        CLOSE cuActividadGene;
    
        IF nuActividad IS NOT NULL THEN
        
            sbObserva := 'Solicitud Generada por proceso de autoreconectado, orden #'||nuorden;
    
            sbRequestXML := pkg_xml_soli_vsi.getSolicitudVSI
            (
                nuContrato      ,         
                nuMedioRecepcion,   
                sbObserva       ,          
                nuProductId     ,        
                inuContactIdsol ,    
                nuPersonIdsol   ,      
                nuPtoAtncndsol  ,     
                SYSDATE         ,            
                inuIdAddress    ,       
                inuIdAddress    ,       
                nuActividad         
            );

            /*Ejecuta el XML creado*/
            API_REGISTERREQUESTBYXML(sbRequestXML,
                                      nuPackageId,
                                      nuMotiveId,
                                      onuErrorCode,
                                      sbmensa);
            
    
            IF nupackageid IS NULL THEN
                RAISE  pkg_Error.CONTROLLED_ERROR;
            ELSE
                insert into LDC_BLOQ_LEGA_SOLICITUD(PACKAGE_ID_ORIG, PACKAGE_ID_GENE) values(nupakageid,  nuPackageId);

                nuUnidad := pkg_BCOrdenes.fnuObtieneUnidadOperativa(nuorden);

                INSERT INTO LDC_ORDEASIGPROC
                (
                ORAPORPA, ORAPSOGE,ORAOPELE,ORAOUNID,ORAOCALE,  ORAOITEM, ORAOPROC
                )
                VALUES
                ( nuorden, nuPackageId, pkg_bcordenes.fnuObtenerPersona(nuorden),pkg_BCOrdenes.fnuObtieneUnidadOperativa(nuorden),  nuCausalLeg, sbItemAdic, 'AUTORECO');

            END IF;

        ELSE
            pkg_error.setErrorMessage( isbMsgErrr => 'No existe actividad configurada para el tipo de trabajo '||nuTitrSusp||' valiadar parametros LDC_TITRSUSPACORP y LDC_TITRSUSPACORP');
        END IF;

        PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
    END LDC_PROGENTRAMVSI;

    PROCEDURE LDC_VALILECTAUTO IS
     /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de validar lecturas

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.LDC_VALILECTAUTO';
       
        nuOrden   number;
        sbNombreAtrib VARCHAR2(100)  := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_NOMBPARLECT');

        sbLecturas VARCHAR2(4000);

        CURSOR cuDatosLect IS
        SELECT value1||'>'|| nvl(value2,'')||'>'||nvl(value3,'')||'>'||nvl(value4,'')
        FROM or_order_activity
        WHERE order_id =nuOrden;

        CURSOR cudatosvalid IS
        SELECT REGEXP_SUBSTR(sbLecturas, '[^' || '>' || ']+', 1, level ) valor, ROWNUM numero
        FROM dual        
        CONNECT BY regexp_substr(sbLecturas, '[^' || '>' || ']+', 1, level) is not null     
        ;

        sbmensa      VARCHAR2(10000);
        nuClasiCausal NUMBER;
        onuErrorCode  number;
        nuLinea    number:= 0;
        
        sbproceso  VARCHAR2(100)  := 'LDC_VALILECTAUTO' ||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        -- Inicializamos el proceso
        PKG_ESTAPROC.PRINSERTAESTAPROC(sbproceso,1);

        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden       := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;

        nuClasiCausal := pkg_BCOrdenes.fnuObtieneClaseCausal(pkg_BCOrdenes.fnuObtieneCausal(nuorden));

        IF nuClasiCausal = 1 THEN
        
            OPEN cuDatosLect;
            FETCH cuDatosLect INTO sbLecturas;
            CLOSE cuDatosLect;

            IF sbLecturas IS NOT NULL THEN
                FOR reg IN  cudatosvalid LOOP
                    IF reg.valor = sbNombreAtrib THEN
                      nuLinea := reg.numero +1;
                    END IF;

                    IF nuLinea = reg.numero  THEN
                        IF TO_NUMBER(reg.valor) <= 0 THEN
                            pkg_error.setErrorMessage( isbMsgErrr => 'Error en proceso LDC_PKGENEORDEAUTORECO.LDC_VALILECTAUTO La lectura legalizada no puede ser menor o igual a 0');
                        ELSE
                            EXIT;
                        END IF;
                        END IF;
                END LOOP;
            END IF;
        END IF;
        
        PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
             
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
    END LDC_VALILECTAUTO;
   
    PROCEDURE LDC_PROVALIESTAPRSU IS
    /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de validar si un producto esta suspendido por RP

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.LDC_PROVALIESTAPRSU';

        sbmensa      VARCHAR2(10000);
        nuClasiCausal NUMBER;
        nuorden NUMBER;
        onuErrorCode  NUMBER;

        sbTipoSuspRp VARCHAR2(200) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TIPOSUSPRP');

         --se consulta datos del producto
        CURSOR cuDatosProdu IS
        SELECT  oa.product_id
        FROM or_order_activity oa, pr_product p
        WHERE oa.order_id=nuorden
          and p.product_id = oa.product_id
          and p.product_status_id = 2;

        nuProduct_id NUMBER;

        --se consulta marca del producto
        CURSOR cuMarcaProd IS
        SELECT 'X'
        FROM pr_prod_suspension
        WHERE active = 'Y'
        AND product_id = nuProduct_id
        AND suspension_type_id IN 
        (

            SELECT TO_NUMBER(REGEXP_SUBSTR(sbTipoSuspRp, '[^' || csbCOMA || ']+', 1, level ))
            FROM dual        
            CONNECT BY regexp_substr(sbTipoSuspRp, '[^' || csbCOMA || ']+', 1, level) is not null  
        );

        sbdatos VARCHAR2(1);

        sbproceso  VARCHAR2(100)  := 'LDC_PROVALIESTAPRSU' ||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);    

    BEGIN
 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
     
        -- Inicializamos el proceso
        PKG_ESTAPROC.PRINSERTAESTAPROC(sbproceso,1);

        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorden       := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;

        nuClasiCausal := pkg_BCOrdenes.fnuObtieneClaseCausal(pkg_BCOrdenes.fnuObtieneCausal(nuorden));

        IF nuClasiCausal = 1 THEN
            OPEN cuDatosProdu;
            FETCH cuDatosProdu INTO nuProduct_id ;
            IF cuDatosProdu%NOTFOUND THEN
               CLOSE cuDatosProdu;
               pkg_error.setErrorMessage( isbMsgErrr => 'Error en proceso LDC_PKGENEORDEAUTORECO.LDC_PROVALIESTAPRSU, producto no se encuentra suspendido');
            END IF;
            CLOSE cuDatosProdu;

            OPEN cuMarcaProd;
            FETCH cuMarcaProd INTO sbdatos;
            IF cuMarcaProd%NOTFOUND THEN
                CLOSE cuMarcaProd;
                pkg_error.setErrorMessage( isbMsgErrr => 'Error en proceso LDC_PKGENEORDEAUTORECO.LDC_PROVALIESTAPRSU, producto no se encuentra suspendido por RP( Parametro LDC_TIPOSUSPRP )');
            END IF;
            CLOSE cuMarcaProd;

        END IF;
     
        PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);     

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
    END LDC_PROVALIESTAPRSU;

    PROCEDURE LDC_PROCREASOLIRECOSINCERT IS
    /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar tramite de reinstalacion y reco rp

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.LDC_PROCREASOLIRECOSINCERT';
           
        sbrequestxml1       VARCHAR2(32767);
        nupackageid         mo_packages.package_id%TYPE;
        numotiveid          mo_motive.motive_id%TYPE;
        nuerrorcode         NUMBER;
        sberrormessage      VARCHAR2(10000);
        nucont              NUMBER(4);
        rcComponent         damo_component.stymo_component;
        rcmo_comp_link      damo_comp_link.stymo_comp_link;
        nunumber            NUMBER(4) DEFAULT 0;
        nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
        sbtagname           mo_component.tag_name%TYPE;
        nuclasserv          mo_component.class_service_id%TYPE;
        nucomppadre         mo_component.component_id%TYPE;

        sbmensa             VARCHAR2(10000);
        nupakageid          mo_packages.package_id%TYPE;
        nucliente           ge_subscriber.subscriber_id%TYPE;
        numediorecepcion    mo_packages.reception_type_id%TYPE;
        sbdireccionparseada ab_address.address_parsed%TYPE;
        nudireccion         ab_address.address_id%TYPE;
        nulocalidad         ab_address.geograp_location_id%TYPE;
        nucategoria         mo_motive.category_id%TYPE;
        nusubcategori       mo_motive.subcategory_id%TYPE;
        sbComment           VARCHAR2(2000);
        nuProductId         NUMBER;
        nuContratoId        NUMBER;
        nuTaskTypeId        NUMBER;
        sw                  NUMBER(2) DEFAULT 0;

        nuunidadoperativa   or_order.operating_unit_id%TYPE;
        nuestadosolicitud   mo_packages.motive_status_id%TYPE;
        sbsolicitudes       VARCHAR2(1000);
        nuorden   number;

        dtFechaAsig         or_order.ASSIGNED_DATE%TYPE;
        dtFechaEjecIni      or_order.EXEC_INITIAL_DATE%TYPE;
        dtFechaEjecFin      or_order.EXECUTION_FINAL_DATE%TYPE;
        dtFechaLega         or_order.LEGALIZATION_DATE%TYPE;

        sbTipoSuspe          VARCHAR2(100) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TIPOSUSP_RECO');

        sbTipoSuspeTra          VARCHAR2(100) := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_RP_SUSPENSION_TYPE');
        sbdato               VARCHAR(1);

        CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
        SELECT pv.package_id colsolicitud
        FROM mo_packages pv,mo_motive mv
        WHERE pv.package_type_id     IN 
        (
            SELECT TO_NUMBER(REGEXP_SUBSTR(pkg_BCLD_Parameter.fsbObtieneValorCadena('VAL_TRAMITES_NUEVOS_FLUJOS'), '[^' || csbCOMA || ']+', 1, level ))
            FROM dual        
            CONNECT BY regexp_substr(pkg_BCLD_Parameter.fsbObtieneValorCadena('VAL_TRAMITES_NUEVOS_FLUJOS'), '[^' || csbCOMA || ']+', 1, level) is not null           
        )
        AND pv.motive_status_id = pkg_BCLD_Parameter.fnuObtieneValorNumerico('ESTADO_SOL_REGISTRADA')
        AND mv.product_id       = nucuproducto
        AND pv.package_id       = mv.package_id;

        --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
        CURSOR cuProducto(nucuorden NUMBER) IS
        SELECT product_id, subscription_id, oa.task_type_id,oa.package_id,oa.subscriber_id,ot.operating_unit_id, 13 estado_sol, ot.ASSIGNED_DATE,
                ot.EXEC_INITIAL_DATE,
                ot.EXECUTION_FINAL_DATE,
                ot.LEGALIZATION_DATE
        FROM or_order_activity oa,or_order ot--,mo_packages m
        WHERE oa.order_id = nucuorden
        AND oa.order_id = ot.order_id
        AND rownum   = 1;

        -- Cursor para obtener los componentes asociados a un motivo
        CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
        SELECT COUNT(1)
        FROM mo_component C
        WHERE c.package_id = nucumotivos;

        -- Se consulta si el producto esta suspendido
        CURSOR cuEstadoProducto(nuProducto pr_product.product_id%type) IS
        SELECT 'X'
        FROM PR_PRODUCT P, pr_prod_suspension PS
        WHERE P.PRODUCT_ID = PS.PRODUCT_ID AND
        P.PRODUCT_ID = nuProducto 
        AND P.PRODUCT_STATUS_ID = 2
        AND PS.ACTIVE = 'Y' 
        AND PS.SUSPENSION_TYPE_ID IN 
        ( 
            SELECT TO_NUMBER(REGEXP_SUBSTR(sbTipoSuspeTra, '[^' || csbCOMA || ']+', 1, level ))
            FROM dual        
            CONNECT BY regexp_substr(sbTipoSuspeTra, '[^' || csbCOMA || ']+', 1, level) is not null           
        );

        numarca number;
      
        sbproceso  VARCHAR2(100)  := 'LDC_PROCREASOLIRECOSINCERT' ||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');    

        CURSOR cuProductoAdicional
        IS
        SELECT  di.address_parsed
                ,di.address_id
                ,di.geograp_location_id
                ,pr.category_id
                ,pr.subcategory_id
        FROM pr_product pr,ab_address di
        WHERE pr.product_id = nuproductid
        AND pr.address_id = di.address_id;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
      
    BEGIN
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        nuorden       := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;

        -- Inicializamos el proceso
        PKG_ESTAPROC.PRINSERTAESTAPROC(sbproceso,1);
        PKG_TRAZA.TRACE('Numero de la Orden:'||nuorden, 10);
        -- obtenemos el producto y el paquete
        OPEN cuproducto(nuorden);
        FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa,nuestadosolicitud, dtFechaAsig, dtFechaEjecIni, dtFechaEjecFin, dtFechaLega;
            IF cuProducto%NOTFOUND THEN
                sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
                PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
                pkg_error.setErrorMessage( isbMsgErrr => sbmensa );
            END IF;
        CLOSE cuproducto;
        PKG_TRAZA.TRACE('Salio cursor cuProducto, nuProductId: '||nuProductId||'nuContratoId:'||'nuTaskTypeId:'||nuTaskTypeId, 10);

        OPEN  cuEstadoProducto(nuproductid);
        FETCH cuEstadoProducto INTO sbdato;
        IF cuEstadoProducto%NOTFOUND THEN
            sbmensa := 'Proceso termino con errores : '||'El producto: '||to_char(nuproductid)||' no se encuentra suspendido o esta suspendido con un tipo diferente a['||sbTipoSuspe||']';
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
            RETURN;
        END IF;
        CLOSE cuEstadoProducto;
    
        -- Buscamos solicitudes de revisión periodica generadas
        sbsolicitudes := NULL;
        FOR i IN cusolicitudesabiertas(nuproductid) LOOP
            IF sbsolicitudes IS NULL THEN
                sbsolicitudes := i.colsolicitud;
            ELSE
                sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
            END IF;
        END LOOP;

        IF TRIM(sbsolicitudes) IS NULL THEN
      
            -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
            sbdireccionparseada := NULL;
            nudireccion         := NULL;
            nulocalidad         := NULL;
            nucategoria         := NULL;
            nusubcategori       := NULL;
            sw                  := 1;
            
            OPEN cuProductoAdicional;
            FETCH cuProductoAdicional INTO sbdireccionparseada,nudireccion,nulocalidad,nucategoria,nusubcategori;
            CLOSE cuProductoAdicional;

            IF nudireccion IS NULL THEN
                sw := 0;
            END IF;
        
            IF sw = 1 THEN
                numarca := ldc_fncretornamarcaprod(nuproductid);
            
                -- Construimos el XML para generar la orden de reconexión sin certificación
                sbcomment        := substr(ldc_retornacomentotlega(nuorden),1,2000)||' orden legalizada : '||to_char(nuorden)||' REGENERACION ';
                numediorecepcion := pkg_BCLD_Parameter.fnuObtieneValorNumerico('MEDIO_RECEPCION_RECO_SIN_CERT');
            
                sbrequestxml1 := pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp
                            (
                                numediorecepcion,   
                                sbcomment       ,   
                                nuproductid     ,   
                                nucliente       ,   
                                numarca
                            );        
        
                -- Procesamos el XML y generamos la solicitud
                API_REGISTERREQUESTBYXML(
                                          sbrequestxml1,
                                          nupackageid,
                                          numotiveid,
                                          nuerrorcode,
                                          sberrormessage
                                         );
                IF nupackageid IS NULL THEN
                    sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud. Codigo error : '||to_char(nuerrorcode)||' Mensaje de error : '||sberrormessage;
                    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
                    pkg_error.setErrorMessage( isbMsgErrr => sbmensa );   
                ELSE

                    sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||to_char(nupackageid);
                    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
                
                END IF;
       
                -- Consultamos si el motivo generado tiene asociado los componentes
                OPEN cuComponente(numotiveid);
                FETCH cuComponente INTO nucont;
                CLOSE cuComponente;
        
                -- Si el motivo no tine los componentes asociados, se procede a registrarlos
                IF (nucont=0)THEN
                    FOR i IN (
                              SELECT kl.*,mk.package_id solicitud,mk.subcategory_id subcategoria
                                FROM mo_motive mk,pr_component kl
                               WHERE mk.motive_id = numotiveid
                                 AND kl.component_status_id <> 9
                                 AND mk.product_id = kl.product_id
                               ORDER BY kl.component_type_id
                              ) 
                    LOOP
                        IF i.component_type_id = 7038 THEN
                            nunumber     := 1;
                            nuprodmotive := 10346;
                            sbtagname    := 'C_GAS_10346';
                            nuclasserv   := NULL;
                        ELSIF i.component_type_id = 7039 THEN
                            nunumber     := 2;
                            nuprodmotive := 10348;
                            sbtagname    := 'C_MEDICION_10348';
                            nuclasserv   := 3102;
                        END IF;
                        rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
                        rcComponent.component_number     := nunumber;
                        rcComponent.obligatory_flag      := 'N';
                        rcComponent.obligatory_change    := 'N';
                        rcComponent.notify_assign_flag   := 'N';
                        rcComponent.authoriz_letter_flag := 'N';
                        rcComponent.status_change_date   := SYSDATE;
                        rcComponent.recording_date       := SYSDATE;
                        rcComponent.directionality_id    := 'BI';
                        rcComponent.custom_decision_flag := 'N';
                        rcComponent.keep_number_flag     := 'N';
                        rcComponent.motive_id            := numotiveid;
                        rcComponent.prod_motive_comp_id  := nuprodmotive;
                        rcComponent.component_type_id    := i.component_type_id;
                        rcComponent.motive_type_id       := 75;
                        rcComponent.motive_status_id     := 15;
                        rcComponent.product_motive_id    := 100304;
                        rcComponent.class_service_id     := nuclasserv;
                        rcComponent.package_id           := nupackageid;
                        rcComponent.product_id           := i.product_id;
                        rcComponent.service_number       := i.product_id;
                        rcComponent.component_id_prod    := i.component_id;
                        rcComponent.uncharged_time       := 0;
                        rcComponent.product_origin_id    := i.product_id;
                        rcComponent.quantity             := 1;
                        rcComponent.tag_name             := sbtagname;
                        rcComponent.is_included          := 'N';
                        rcComponent.category_id          := i.category_id;
                        rcComponent.subcategory_id       := i.subcategoria;
                        damo_component.Insrecord(rcComponent);
                        
                        IF i.component_type_id = 7038 THEN
                            nucomppadre :=  rcComponent.component_id;
                        END IF;
                        
                        IF(nuMotiveId IS NOT NULL)THEN
                            rcmo_comp_link.child_component_id  := rcComponent.component_id;
                            IF i.component_type_id = 7039 THEN
                                rcmo_comp_link.father_component_id := nucomppadre;
                            ELSE
                                rcmo_comp_link.father_component_id := NULL;
                            END IF;
                            rcmo_comp_link.motive_id           := nuMotiveId;
                            damo_comp_link.insrecord(rcmo_comp_link);
                        END IF;
                    END LOOP;
                END IF;
            ELSE
                sbmensa := 'Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||to_char(nuorden);
                PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
                pkg_error.setErrorMessage( isbMsgErrr => sbmensa );
            END IF;
        ELSE
            sbmensa := 'Proceso termino. : El producto : '||to_char(nuproductid)||' ya tiene una solicitud de reconexión sin certificación en estado registrada.';
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Ok',sbmensa);
            pkg_error.setErrorMessage( isbMsgErrr => sbmensa );     
        END IF;
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso,'Error',sbError);
            RAISE pkg_error.Controlled_Error;
    END LDC_PROCREASOLIRECOSINCERT;

    /**************************************************************************
        Programa    :   pCargagtbEscoFact
        Autor       :   Lubin Pineda - MVM
        Fecha       :   2023-05-23
        Ticket      :   OSF-1075
        Descripcion :   Llena la tabla gtbEscoFact si está vacía con los 
                        estados de corte facturables del tipo de producto
                        cnuSERV_GAS

        Parametros Entrada:

        Valores posibles de salida     

        HISTORIA DE MODIFICACIONES
        FECHA       AUTOR       DESCRIPCION
        23/05/2023  JPINEDC     Creación
   ***************************************************************************/
    PROCEDURE pCargagtbEscoFact
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pCargagtbEscoFact';
    
        CURSOR cuEscoFact
        IS
        SELECT *
        FROM confesco
        WHERE coecserv = cnuSERV_GAS
        AND coecfact = 'S';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        IF gtbEscoFact.COUNT = 0 THEN
    
            FOR rgEscoFact IN cuEscoFact LOOP
            
                gtbEscoFact( rgEscoFact.coeccodi ) := 1;
            
            END LOOP;
            
        END IF;

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
    END pCargagtbEscoFact;
    
    /**************************************************************************
        Programa    :   fdtFechIniVolFact
        Autor       :   Lubin Pineda - MVM
        Fecha       :   2023-09-28
        Ticket      :   OSF-1635
        Descripcion :   Retorna la fecha inicial para el calculo del volumen facturado    

        Parametros Entrada:
            idtFechaSusp     : Fecha de suspensión

        HISTORIA DE MODIFICACIONES
        FECHA       AUTOR       DESCRIPCION
        28/09/2023  JPINEDC     OSF-1635: Creación
        25/10/2023  JPINEDC     OSF-1635: Si la fecha calculada con el parámetro
                                es menor a la de suspensión se retorna la de
                                suspensión
   ***************************************************************************/    
    FUNCTION fdtFechIniVolFact ( idtFechaSusp DATE ) 
    RETURN DATE
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fdtFechIniVolFact';
    
        dtFechIniVolFact DATE;

        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        PKG_TRAZA.TRACE( 'cnuMESES_PERSCA_AUTORECO|' || cnuMESES_PERSCA_AUTORECO , 10);    
        
        IF NVL( cnuMESES_PERSCA_AUTORECO, 0) <= 0 THEN
            dtFechIniVolFact := idtFechaSusp;
        ELSE
            dtFechIniVolFact := TRUNC(ADD_MONTHS ( SYSDATE , - cnuMESES_PERSCA_AUTORECO));
            
            IF dtFechIniVolFact < idtFechaSusp THEN
                dtFechIniVolFact := idtFechaSusp;
            END IF;
            
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN dtFechIniVolFact;
        
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
    END fdtFechIniVolFact;

    /**************************************************************************
        Programa    :   fsbVolFactMayToler
        Autor       :   Lubin Pineda - MVM
        Fecha       :   2023-05-23
        Ticket      :   OSF-1075
        Descripcion :   Función para determinar si el volumen neto facturado 
                        posterior a la fecha menor o igual al tolerado

        Parametros Entrada:
            inuProducto     : Producto
            inuSeSuEsCo     : Estado de corte
            idtFechaSusp    : Fecha de lectura de suspensión
            inuSeSuCiCo     : Ciclo de consumo

        Valores posibles de salida     
            X:  Producto NO facturable 
            S:  Producto Facturable y volumen neto facturado posterior 
                a la fecha mayor al tolerado
            N:  Producto Facturable y volumen neto facturado posterior 
                a la fecha menor o igual al tolerado

        HISTORIA DE MODIFICACIONES
        FECHA       AUTOR       DESCRIPCION
        23/05/2023  JPINEDC     Creación
        28/09/2023  JPINEDC     OSF-1635: 
                                * Se ejecuta fdtFechIniVolFact para obtener
                                la fecha inicial de búsqueda
                                * Se modifica cuVoluFactPostSusp para
                                que reciba la fecha inicial de búsqueda 
        31/10/2023  JPINEDC     OSF-1635: en el cursor se incluye
                                condición del flag pecsflav = 'S'
   ***************************************************************************/
    FUNCTION fsbVolFactMayToler( inuProducto NUMBER, inuSeSuEsCo NUMBER, idtFechaSusp DATE, inuSeSuCiCo NUMBER ) 
    RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fsbVolFactMayToler';
            
        -- Volumen facturado neto posterior a la fecha de lectura suspensión	 
        nuVoluFactPostSusp  NUMBER;
        
        sbVolFactMayToler   VARCHAR2(1) := 'N';
        
        dtFechIniVolFact    DATE;
        
		-- Obtiene el volumen facturado neto posterior a la fecha de lectura suspensión
		CURSOR cuVoluFactPostSusp( idtFechIniVolFact DATE, idtFechSuspension DATE ) IS
			WITH causas AS
			(
				SELECT /*+ MATERIALIZED */ REGEXP_SUBSTR( csbCAUSCARG_PERSCA, '[^,]+', 1, level ) codigo
				FROM DUAL
				CONNECT BY REGEXP_SUBSTR( csbCAUSCARG_PERSCA, '[^,]+', 1, level) is not null  
			)
			SELECT /*+ INDEX ( CARGOS IX_CARG_NUSE_CUCO_CONC ) */
				   SUM( CASE ca.cargsign WHEN 'DB' THEN cargunid WHEN 'CR' then -cargunid END ) volumen
			FROM cargos ca
			WHERE ca.cargnuse = inuProducto
			AND ca.cargcuco > 0
			AND ca.cargconc = cnuCONCEPTO_CONSUMO
			AND ca.cargcaca IN (  SELECT codigo FROM causas )
			AND ca.cargsign IN ( 'DB','CR' )
			AND ca.cargfecr > idtFechIniVolFact
			AND ca.cargpeco IN
			(
                SELECT pecscons
                FROM pericose pc
                WHERE pc.pecscico = inuSeSuCiCo
                AND   pc.pecsfeci >= idtFechIniVolFact
                AND   pc.pecsfeci > idtFechSuspension
                AND   pc.pecsflav = 'S'
			);           
                
			
        nuError NUMBER;
        sbError VARCHAR2(4000);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        PKG_TRAZA.TRACE( 'idtFechaSusp|' || to_char(idtFechaSusp,'dd/mm/yyyy hh24:mi:ss'), 10);        
        
        pCargagtbEscoFact;

        IF gtbEscoFact.exists( inuSeSuEsCo ) THEN

            nuVoluFactPostSusp := NULL; 
            
            dtFechIniVolFact := fdtFechIniVolFact(idtFechaSusp);
            
            PKG_TRAZA.TRACE( 'dtFechIniVolFact|' || to_char(dtFechIniVolFact,'dd/mm/yyyy hh24:mi:ss'), 10);              
            
            -- Obtiene el volumen facturado neto posterior a la fecha de lectura suspensión
            OPEN cuVoluFactPostSusp(dtFechIniVolFact, idtFechaSusp);---
            FETCH cuVoluFactPostSusp INTO nuVoluFactPostSusp;
            CLOSE cuVoluFactPostSusp;				

            PKG_TRAZA.TRACE( 'gnuToleranciaDif|' || gnuToleranciaDif, 10); 
            
            -- Si el volumen facturado neto posterior a la fecha de lectura suspensión es menor
            -- o igual al tolerado se procesa el siguiente producto
            IF NVL(nuVoluFactPostSusp,0) > gnuToleranciaDif THEN
                sbVolFactMayToler := 'S';                
            END IF;
            
        ELSE
            -- Indica que el producto esta en un estado de cartera no facturable
            sbVolFactMayToler := 'X';	                			
        END IF;    
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        
            
        RETURN sbVolFactMayToler;
        
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
    END fsbVolFactMayToler;
    
    -- Valida los parámetros usados exclusivamente en procesos de autoreconetados
    PROCEDURE pValParAutorecon( inuProceso NUMBER )
    IS
        csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pValParAutorecon';
            
        TYPE tytbLD_PARAMETER_AUTORECO IS TABLE OF VARCHAR2(200) INDEX BY BINARY_INTEGER;
        
        tbLD_PARAMETER_AUTORECO tytbLD_PARAMETER_AUTORECO;

        -- Parámetros exclusivos de los procesos de AutoReconectados
        CURSOR cuLD_PARAMETER(isbParametro VARCHAR2)
        IS
        SELECT *
        FROM ld_parameter
        WHERE parameter_id = isbParametro;
        
        rcLD_PARAMETER      cuLD_PARAMETER%ROWTYPE;
        
        sbParametrosNoEx    GE_ERROR_LOG.DESCRIPTION%TYPE;
                
        sbParametrosNull    GE_ERROR_LOG.DESCRIPTION%TYPE;
        
        sbParametrosNeg     GE_ERROR_LOG.DESCRIPTION%TYPE;
        
        sbMensaje           GE_ERROR_LOG.DESCRIPTION%TYPE;
        
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        
        PROCEDURE pInicia
        IS
        BEGIN
        
            sbParametrosNoEx    := NULL;
                    
            sbParametrosNull    := NULL;
            
            sbParametrosNeg     := NULL;
            
            sbMensaje           := NULL; 
            
        END pInicia;       
        
        PROCEDURE pCargtbLD_PARAMETER_AUTORECO
        IS
        BEGIN
            tbLD_PARAMETER_AUTORECO.DELETE;
            tbLD_PARAMETER_AUTORECO(tbLD_PARAMETER_AUTORECO.COUNT+1) := 'TOLERANCIA_DIFE_AUTORECONE';
            tbLD_PARAMETER_AUTORECO(tbLD_PARAMETER_AUTORECO.COUNT+1) := 'TOLERANCIA_DIFE_AUTORECONE_SN';
            tbLD_PARAMETER_AUTORECO(tbLD_PARAMETER_AUTORECO.COUNT+1) := 'CAUSCARG_PERSCA';
        END pCargtbLD_PARAMETER_AUTORECO;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        PKG_TRAZA.TRACE( 'inuProceso|' || inuProceso, 10); 
        
        pInicia;
        
        pCargtbLD_PARAMETER_AUTORECO;
                               
        IF INSTR( csbCOMA || cnuLDC_PROCAUTORECO ||  csbCOMA || csbPROCAUTORECO_SN || csbCOMA , csbCOMA || inuProceso || csbCOMA ) > 0
        THEN
        
            PKG_TRAZA.TRACE( 'Es autoreconectado', 10);
       
            FOR indtbPar IN 1..tbLD_PARAMETER_AUTORECO.COUNT LOOP
            
                PKG_TRAZA.TRACE( 'Parametro|'|| tbLD_PARAMETER_AUTORECO(indtbPar), 10); 
                
                rcLD_PARAMETER := NULL;
                
                OPEN cuLD_PARAMETER(tbLD_PARAMETER_AUTORECO(indtbPar));
                FETCH cuLD_PARAMETER INTO rcLD_PARAMETER;
                CLOSE cuLD_PARAMETER;
                
                PKG_TRAZA.TRACE( 'rcLD_PARAMETER.Parameter_Id|'||rcLD_PARAMETER.Parameter_Id, 10);
            
                IF rcLD_PARAMETER.Parameter_Id IS NOT NULL THEN
                
                    IF  rcLD_PARAMETER.Numeric_Value IS NULL 
                        AND rcLD_PARAMETER.Value_Chain IS NULL 
                    THEN
                    
                        sbParametrosNull :=  sbParametrosNull || tbLD_PARAMETER_AUTORECO(indtbPar) || csbCOMA;
                        
                    ELSE
                    
                        IF rcLD_PARAMETER.Numeric_Value = -1 OR rcLD_PARAMETER.Value_Chain = '-1' THEN
                            sbParametrosNeg := tbLD_PARAMETER_AUTORECO(indtbPar) || csbCOMA;
                        END IF;
                                            
                    END IF;
                            
                ELSE
                
                                        
                    sbParametrosNoEx := sbParametrosNoEx || tbLD_PARAMETER_AUTORECO(indtbPar) || csbCOMA;
                
                END IF; 
                
            END LOOP;                              

        END IF;

        IF sbParametrosNull IS NOT NULL THEN
        
            sbParametrosNull := SUBSTR( sbParametrosNull,1, LENGTH(sbParametrosNull)-1);
                                    
        END IF;
        
        IF sbParametrosNeg IS NOT NULL THEN
        
            sbParametrosNeg := SUBSTR( sbParametrosNeg,1, LENGTH(sbParametrosNeg)-1);
                                    
        END IF;
        
        IF sbParametrosNoEx IS NOT NULL THEN
        
            sbParametrosNoEx := SUBSTR( sbParametrosNoEx,1, LENGTH(sbParametrosNoEx)-1);
                                    
        END IF;
        
        PKG_TRAZA.TRACE( 'sbParametrosNoEx|'||sbParametrosNoEx, 10);
        PKG_TRAZA.TRACE( 'sbParametrosNull|'||sbParametrosNull, 10);
        PKG_TRAZA.TRACE( 'sbParametrosNeg|'||sbParametrosNeg, 10);
        
        IF sbParametrosNoEx IS NOT NULL THEN

            sbMensaje := sbMensaje || 'El(los) parámetro(s) ' || sbParametrosNoEx || ' no existen.';
            
        END IF;
        
        IF sbParametrosNull IS NOT NULL THEN

            sbMensaje := sbMensaje || 'El(los) parámetro(s) ' || sbParametrosNull || ' tienen Valor Nulo.';
            
        END IF;
        
        IF sbParametrosNeg IS NOT NULL THEN

            sbMensaje := sbMensaje || 'El(los) parámetro(s) ' || sbParametrosNeg || ' tienen Valor Negativo.';
            
        END IF;
        
        IF sbMensaje IS NOT NULL THEN
            sbMensaje := sbMensaje || 'Favor validar';
        END IF;        
       
        PKG_TRAZA.TRACE( 'sbMensaje|'||sbMensaje, 10);

        IF sbMensaje IS NOT NULL THEN
                                                    
            pkg_error.setErrorMessage( isbMsgErrr => sbMensaje );

        END IF;
        
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
    END pValParAutorecon;
        
    PROCEDURE pCargTblProgCadenaJobsPERSCA( inuTotalHilos NUMBER ) IS

        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCargTblProgCadenaJobsPERSCA';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rcPrograma      pkg_Scheduler.tyrcPrograma;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        tbSchedChainProg.DELETE;

        rcPrograma.PROGRAM_NAME     := 'INI_' || gsbProgramIndi;
        rcPrograma.PACKAGE          := UPPER('LDC_PKGENEORDEAUTORECO');
        rcPrograma.API              := UPPER('prIniCadenaJobsPERSCA');
        rcPrograma.PROGRAM_TYPE     := 'STORED_PROCEDURE';
        rcPrograma.STEP             := 'INI_' || gsbProgramIndi;
        rcPrograma.BLOQUEPL         := NULL;
        rcPrograma.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( rcPrograma.PACKAGE , rcPrograma.API  , rcPrograma.PROGRAM_TYPE, rcPrograma.BLOQUEPL );

        tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  rcPrograma;

        FOR IND IN 1..inuTotalHilos LOOP

            rcPrograma.PROGRAM_NAME := gsbProgramIndi || '_'|| IND;
            rcPrograma.PACKAGE      := UPPER('LDC_PKGENEORDEAUTORECO');
            rcPrograma.API          := UPPER('progeneraPersca');
            rcPrograma.PROGRAM_TYPE := 'STORED_PROCEDURE';
            rcPrograma.BLOQUEPL     := NULL;
            rcPrograma.STEP         := gsbProgramIndi || '_'|| IND;
            rcPrograma.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( rcPrograma.PACKAGE , rcPrograma.API  , rcPrograma.PROGRAM_TYPE, rcPrograma.BLOQUEPL );

            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  rcPrograma;

        END LOOP;


        rcPrograma.PROGRAM_NAME     := 'FIN_' || gsbProgramIndi;
        rcPrograma.PACKAGE          := UPPER('LDC_PKGENEORDEAUTORECO');
        rcPrograma.API              := UPPER('prFinCadenaJobsPERSCA');
        rcPrograma.PROGRAM_TYPE     := 'STORED_PROCEDURE';
        rcPrograma.STEP             := 'FIN_' || gsbProgramIndi;
        rcPrograma.BLOQUEPL         := NULL;

        rcPrograma.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( rcPrograma.PACKAGE , rcPrograma.API  , rcPrograma.PROGRAM_TYPE, rcPrograma.BLOQUEPL );

        tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  rcPrograma;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pCargTblProgCadenaJobsPERSCA;

	PROCEDURE pCreaReglasCadenaJobsPERSCA(inuTotalHilos NUMBER)
	IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaReglasCadenaJobsPERSCA';

		sbCondicion     VARCHAR2(4000);
		sbAccion        VARCHAR2(4000);

		nuError         NUMBER;
		sbError         VARCHAR2(4000);

	BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		sbCondicion := 'FALSE';
		sbAccion   := 'start INI_' || gsbProgramIndi;

		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsPERSCA,
		   sbCondicion,
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion    := 'start ';

		FOR IND0 IN 1..inuTotalHilos LOOP

			sbAccion   := sbAccion || gsbProgramIndi || '_' || IND0 ;

			IF IND0 < inuTotalHilos THEN
				sbAccion := sbAccion ||  ',';
			END IF;

		END LOOP;

		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsPERSCA,
		   sbCondicion,
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion := 'start FIN_' || gsbProgramIndi;

		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsPERSCA,
		   sbCondicion,
		   sbACCION
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion := 'END';

		-- termina la cadena
		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsPERSCA,
		   sbCondicion,
		   sbAccion
		);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
	END pCreaReglasCadenaJobsPERSCA;
        
    PROCEDURE pCreaCadenaJobsPERSCA(inuTotalHilos NUMBER)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaCadenaJobsPERSCA';

        nuError NUMBER;
        sbError VARCHAR2(4000);

        tbArgumentos  pkg_Scheduler.tytbArgumentos;

        tbProgramas   pkg_scheduler.tytbProgramas;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCargTblProgCadenaJobsPERSCA(inuTotalHilos);

        IF pkg_scheduler.FBLSCHEDCHAINEXISTS( gsbChainJobsPERSCA ) THEN
            pkg_Traza.trace('Ya existe la cadena ' || gsbChainJobsPERSCA, csbNivelTraza );

            tbProgramas := pkg_scheduler.ftbProgramas( gsbProgramIndi );

            IF
            (
                NVL(tbProgramas.Count,0) <> ( inuTotalHilos + 2)
                OR
                pkg_scheduler.fblUltEjecCadJobConError(  gsbChainJobsPERSCA )
            )
            THEN

                pkg_scheduler.pDropSchedChain( gsbChainJobsPERSCA );

                pkg_scheduler.create_chain( gsbChainJobsPERSCA );

            END IF;

        ELSE
            pkg_scheduler.create_chain( gsbChainJobsPERSCA );
        END IF;

        FOR indtbPr IN 1..tbSchedChainProg.COUNT LOOP

            pkg_Traza.trace('paso|'|| tbSchedChainProg(indtbPr).step, csbNivelTraza );
            pkg_Traza.trace('programa|' || tbSchedChainProg(indtbPr).package || '.' || tbSchedChainProg(indtbPr).api,csbNivelTraza);

            tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN',tbSchedChainProg(indtbPr).package, tbSchedChainProg(indtbPr).api );

            pkg_Traza.trace('tbArgumentos.count|' || tbArgumentos.count,csbNivelTraza);

            pkg_scheduler.PCREASCHEDCHAINSTEP
            (
                gsbChainJobsPERSCA,
                tbSchedChainProg(indtbPr).step,
                tbSchedChainProg(indtbPr).program_name,
                tbSchedChainProg(indtbPr).program_type,
                tbSchedChainProg(indtbPr).program_action,
                tbArgumentos.count,
                TRUE,
                gsbChainJobsPERSCA,
                nuError,
                sbError
            );

            pkg_Traza.trace('Res pkg_scheduler.PCREASCHEDCHAINSTEP|' || sbError);

            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'pCreaSchedChainStep|' || sbError );
            END IF;

        END LOOP;

        pCreaReglasCadenaJobsPERSCA(inuTotalHilos);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pCreaCadenaJobsPERSCA;
    
   
    PROCEDURE pDefValArgsCadenaJobsPERSCA
    (         
        isbProgram      VARCHAR2, 
        inuProceso      NUMBER, 
        isbCiclo        VARCHAR2, 
        isbDepartamento VARCHAR2, 
        isbLocalidad    VARCHAR2, 
        inuTotalHilos   NUMBER,
        inuLogProcessId      ge_log_process.log_process_id%TYPE        
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pDefValArgsCadenaJobsPERSCA';
        tbArgumentos              pkg_Scheduler.tytbArgumentos;
        sbIndArg            VARCHAR2(100);
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        tbArgumentos.delete;

        tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN', 'LDC_PKGENEORDEAUTORECO', UPPER('prIniCadenaJobsPERSCA'));

        tbArgumentos(UPPER('isbProgram')).VALUE         := isbProgram;        
        tbArgumentos(UPPER('inuProceso')).VALUE         := inuProceso;
        tbArgumentos(UPPER('inuCICLO')).VALUE           := isbCiclo;        
        tbArgumentos(UPPER('inuDepartamento')).VALUE    := isbDepartamento;
        tbArgumentos(UPPER('inuLocalidad')).VALUE       := isbLocalidad;
        tbArgumentos(UPPER('inuLogProcessId')).VALUE    := inuLogProcessId;

        sbStep := 'INI_' || gsbProgramIndi;

        pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

        sbIndArg := tbArgumentos.First;

        LOOP

            EXIT WHEN sbIndArg IS NULL;

            pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

            pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

            pkg_scheduler.define_program_argument
            (
                sbStep,
                tbArgumentos(sbIndArg).position,
                tbArgumentos(sbIndArg).argument_name,
                tbArgumentos(sbIndArg).data_type,
                tbArgumentos(sbIndArg).value,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );

            ELSE
                pkg_Traza.trace( 'OK Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name , csbNivelTraza);
            END IF;

            sbIndArg := tbArgumentos.Next(sbIndArg );

        END LOOP;
        
            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;
        
        
        tbArgumentos.Delete;        

        tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN','LDC_PKGENEORDEAUTORECO', UPPER('progeneraPersca'));
                          
        tbArgumentos(UPPER('isbProgram')).VALUE         := isbProgram;
        tbArgumentos(UPPER('inuProceso')).VALUE         := inuProceso;
        tbArgumentos(UPPER('inuCiclo')).VALUE           := isbCiclo;        
        tbArgumentos(UPPER('inuDepartamento')).VALUE    := isbDepartamento;
        tbArgumentos(UPPER('inuLocalidad')).VALUE       := isbLocalidad;
        tbArgumentos(UPPER('inuTotalHilos')).VALUE      := inuTotalHilos;

        FOR nuHilo in 1..inuTotalHilos LOOP

            tbArgumentos('INUHILO').VALUE := nuHilo;

            sbStep := gsbProgramIndi  || '_' || nuHilo;

            pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

            sbIndArg := tbArgumentos.First;

            LOOP

                EXIT WHEN sbIndArg IS NULL;

                pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

                pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

                pkg_scheduler.define_program_argument
                (
                    sbStep,
                    tbArgumentos(sbIndArg).position,
                    tbArgumentos(sbIndArg).argument_name,
                    tbArgumentos(sbIndArg).data_type,
                    tbArgumentos(sbIndArg).value,
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );
                ELSE
                    pkg_Traza.trace( 'OK Creacion el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name, csbNivelTraza );
                END IF;

                sbIndArg := tbArgumentos.Next(sbIndArg );

            END LOOP;

            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;

        END LOOP;

        tbArgumentos.delete;

        tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN','LDC_PKGENEORDEAUTORECO', UPPER('prFinCadenaJobsPERSCA'));

        tbArgumentos(UPPER('isbProgram')).VALUE         := isbProgram;
        tbArgumentos(UPPER('inuProceso')).VALUE         := inuProceso;
        tbArgumentos(UPPER('inuCiclo')).VALUE            := isbCiclo;        
        tbArgumentos(UPPER('inuDepartamento')).VALUE     := isbDepartamento;
        tbArgumentos(UPPER('inuLocalidad')).VALUE        := isbLocalidad;
        tbArgumentos(UPPER('inuTotalHilos')).VALUE      := inuTotalHilos;

        sbStep := 'FIN_' || gsbProgramIndi;

        pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

        sbIndArg := tbArgumentos.First;

        LOOP

            EXIT WHEN sbIndArg IS NULL;

            pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

            pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

            pkg_scheduler.define_program_argument
            (
                sbStep,
                tbArgumentos(sbIndArg).position,
                tbArgumentos(sbIndArg).argument_name,
                tbArgumentos(sbIndArg).data_type,
                tbArgumentos(sbIndArg).value,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );

            ELSE
                pkg_Traza.trace( 'OK Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name , csbNivelTraza);
            END IF;

            sbIndArg := tbArgumentos.Next(sbIndArg );

        END LOOP;
        
            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;
        

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pDefValArgsCadenaJobsPERSCA;

    PROCEDURE pActivaCadenaJobsPERSCA
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pActivaCadenaJobsPERSCA';
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        sbStep := 'FIN_PERSCA';

        pkg_scheduler.enable
        (
            sbStep,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando el paso ' || sbStep );
        ELSE
            pkg_Traza.trace( 'OK Habilitando el paso ' || sbStep, csbNivelTraza );
        END IF;

        sbStep := 'INI_PERSCA';

        pkg_scheduler.enable
        (
            sbStep,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando el paso ' || sbStep );
        ELSE
            pkg_Traza.trace( 'OK Habilitando el paso ' || sbStep, csbNivelTraza );
        END IF;

        pkg_scheduler.enable
        (
            gsbChainJobsPERSCA,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando la cadena ' || gsbChainJobsPERSCA );
        ELSE
            pkg_Traza.trace( 'OK Habilitando la cadena ' || gsbChainJobsPERSCA, csbNivelTraza );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pActivaCadenaJobsPERSCA;  
    
    FUNCTION fsbInfoPerscaEnEjec RETURN VARCHAR2
    IS
        csbMetodo       CONSTANT VARCHAR2(105) := csbSP_NAME || '.fsbInfoPerscaEnEjec';
        
        sbInfoPerscaEnEjec VARCHAR2(2000);
            
        CURSOR cuInfoPerscaEnEjec
        IS
        SELECT *
        FROM
            estaprog
        WHERE
            esprprog like 'PERSCA_%'
        and esprfein >= sysdate-1
        and esprporc < 100;
        
        rcInfoPerscaEnEjec cuInfoPerscaEnEjec%ROWTYPE;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuInfoPerscaEnEjec;
        FETCH cuInfoPerscaEnEjec INTO rcInfoPerscaEnEjec;
        CLOSE cuInfoPerscaEnEjec;
        
        rcInfoPerscaEnEjec.esprprog := SUBSTR( rcInfoPerscaEnEjec.esprprog, 1, INSTR ( rcInfoPerscaEnEjec.esprprog, '-' ) - 1 );
        
        sbInfoPerscaEnEjec :=   'Datos del proceso PERSCA en ejecucion:' || chr(10) ||
                        'Identificador:' || rcInfoPerscaEnEjec.esprprog || chr(10) ||
                        'Fecha Inicio:' || TO_CHAR(rcInfoPerscaEnEjec.esprfein,'dd/mm/yyyy hh24:mi:ss') || chr(10) ||
                        'Porcentaje Avance:' || rcInfoPerscaEnEjec.esprporc || chr(10) ||
                        'Parametros:' || rcInfoPerscaEnEjec.esprinfo || chr(10);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbInfoPerscaEnEjec;           
    
    END fsbInfoPerscaEnEjec;
    
    -- Genera la cadena de Jobs de PERSCA
    PROCEDURE prgeneraPerscaCadJobs
    (
        isbProgram      VARCHAR2, 
        inuProceso      NUMBER, 
        isbCiclo        VARCHAR2, 
        isbDepartamento VARCHAR2, 
        isbLocalidad    VARCHAR2, 
        inuTotalHilos   NUMBER,
        inuLogProcessId ge_log_process.log_process_id%TYPE           
    )
    IS
        csbMetodo       CONSTANT VARCHAR2(105) := csbSP_NAME || '.prgeneraPerscaCadJobs';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbRecipients    VARCHAR2(2000);	        

        sbMessage0      VARCHAR2(2000);
        
        --CURSOR PARA OBTENER LOS DATOS PRO PROCESO DE PERSECUCION
        CURSOR culdc_Proceso(NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE) IS
        SELECT LP.* FROM LDC_PROCESO LP WHERE LP.PROCESO_ID = NULDC_PROCESO_ID;
        
        rcldc_Proceso          culdc_Proceso%ROWTYPE;
        
        sbParametrosPersca VARCHAR2(2000);
                                          
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        OPEN culdc_Proceso(inuProceso);
        FETCH culdc_Proceso INTO rcldc_Proceso;
        CLOSE culdc_Proceso;
        
        sbRecipients := rcldc_Proceso.EMAIL;
        
        sbParametrosPersca:= ' para generar ordenes de PERSECUCION Para ' || chr(10) ||
                        ' proceso >>>> :' || inuProceso ||chr(10) ||
                        ' ciclo >>>> :' || isbCICLO ||chr(10) ||
                        ' Departamento >>>> :' || isbDepartamento ||chr(10) ||
                        ' Localidad >>>> :' ||isbLocalidad || chr(10) || ' '|| chr(10);
                                        
        IF pkg_scheduler.fblSchedChainRunning( gsbChainJobsPERSCA ) 
           OR
           pkg_scheduler.fblSchedChainRunning( gsbChainJobsPERSCAAutom )
        THEN
        
            sbMessage0 := 'No se pudo ejecutar ' || isbProgram || chr(10) ||
                        sbParametrosPersca || fsbInfoPerscaEnEjec;
                                                                         
            pkg_Correo.prcEnviaCorreo
            (   
                sbRecipients                    ,
                'No se pudo ejecutar ' || isbProgram  ||' porque existe otro proceso PERSCA en ejecución ',
                sbMessage0       
            );
            
        ELSE

            pCreaCadenaJobsPERSCA(inuTotalHilos);

            pDefValArgsCadenaJobsPERSCA
            (         
                isbProgram      , 
                inuProceso      , 
                isbCiclo        , 
                isbDepartamento , 
                isbLocalidad    , 
                inuTotalHilos   ,
                inuLogProcessId
            );

            pActivaCadenaJobsPERSCA;

            pkg_scheduler.run_chain(gsbChainJobsPERSCA , 'INI_' || gsbProgramIndi, 'JOB_' || gsbChainJobsPERSCA );

        END IF;
                  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
             
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);                    
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
            IF sbError LIKE '%ORA-27477%' THEN                                    
                sbMessage0 := 'No se pudo ejecutar ' || isbProgram || chr(10) ||
                            sbParametrosPersca || fsbInfoPerscaEnEjec;
            END IF;
                                                            
            pkg_Correo.prcEnviaCorreo
            (
                sbRecipients                    ,
                'No se pudo ejecutar ' || isbProgram  ||' porque existe otro proceso PERSCA en ejecución ',
                sbMessage0        
            );           
            RAISE pkg_error.Controlled_Error;
            
        WHEN OTHERS THEN        
            pkg_error.setError;              
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );

            sbMessage0 := 'No se pudo ejecutar ' || isbProgram || ' por ERROR NO CONTROLADO: ' || sbError || chr(10) ||
                        sbParametrosPersca;  
                                              
            pkg_Correo.prcEnviaCorreo
            (
                sbRecipients                    ,
                'No se pudo ejecutar ' || isbProgram ,
                sbMessage0        
            );
                         
            RAISE pkg_error.Controlled_Error;
            
    END prgeneraPerscaCadJobs;
        
    -- Progama inicial de la cadena de Jobs de PERSCA
    PROCEDURE prIniCadenaJobsPERSCA
    ( 
        isbProgram      VARCHAR2,
        inuProceso      NUMBER,
        inuCiclo        NUMBER,
        inuDepartamento NUMBER,
        inuLocalidad    NUMBER,
        inuLogProcessId      ge_log_process.log_process_id%TYPE        
    )  
    IS
        csbMetodo       CONSTANT VARCHAR2(105) := csbSP_NAME || '.prIniCadenaJobsPERSCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbSubject       VARCHAR2(2000);
        sbMessage0      VARCHAR2(4000);        

            
        CURSOR culdc_Proceso
        (
            inuProcesId LDC_PROCESO.PROCESO_ID%TYPE
        )
        IS
        SELECT LP.*
        FROM LDC_PROCESO LP
        WHERE LP.PROCESO_ID = inuProcesId;

        rcldc_Proceso          culdc_Proceso%ROWTYPE;
        
        sbParametrosPersca     VARCHAR2(2000);       
                   
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        OPEN culdc_Proceso(inuProceso);
        FETCH culdc_Proceso INTO rcldc_Proceso;
        CLOSE culdc_Proceso;

        sbSubject := 'Inicia ' || isbProgram || ' -  PROCESO ' ||
                     rcldc_Proceso.PROCESO_DESCRIPCION ||
                     ' DE PERSECUCION DE USUARIOS' ||
                     '---> Fecha: ' || to_char(sysdate, 'dd/mm/yyyy HH:MI:SS am');

        IF rcldc_Proceso.EMAIL IS NULL THEN
            sbMessage0 := 'No existe E-mail configurado de los funcionarios encargado del proceso de persecucion para ' ||
                          rcldc_Proceso.PROCESO_DESCRIPCION || ',' || chr(10) ||
                          'Si hay mas de un e-mail seran separados por punto coma (;)' ||
                          chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                          chr(10);
            raise pkg_error.Controlled_Error;
        END IF;
                
        sbRecipients := rcldc_Proceso.EMAIL;

        sbParametrosPersca:= ' para generar ordenes de PERSECUCION Para ' || chr(10) ||
                        ' proceso >>>> :' || inuProceso ||chr(10) ||
                        ' ciclo >>>> :' || inuCICLO ||chr(10) ||
                        ' Departamento >>>> :' || inuDepartamento ||chr(10) ||
                        ' Localidad >>>> :' ||inuLocalidad || chr(10) || ' ' || 
                        chr(10) || ' ' || chr(10) || ' ' || chr(10); 
                                
        --Enviar notificacion
        sbMessage0 := 'Se inicio el proceso de generacion del archivo de usuarios' ||
                    chr(10) ||
                    sbParametrosPersca;

        pkg_Correo.prcEnviaCorreo( sbRecipients, sbSubject, sbMessage0);
        
        /******************************* Fin de envio de correo ***************************/
        DELETE FROM LDC_PRODGENEPER;
        COMMIT;

        DELETE FROM LDC_CONSUMO_CERO lcc
        WHERE lcc.proceso_id = inuProceso
        AND LCC.ciclcodi = decode(inuCICLO, -1, LCC.ciclcodi, inuCICLO);
        
        COMMIT;
                     
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);      
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prIniCadenaJobsPERSCA;      
    
    -- Programa final de la cadena de Jobs de PERSCA    
    PROCEDURE prFinCadenaJobsPERSCA
    (
        isbProgram      VARCHAR2,    
        inuProceso      NUMBER,
        inuCiclo        NUMBER,
        inuDepartamento NUMBER,
        inuLocalidad    NUMBER,
        inuTotalHilos   NUMBER
    )
    IS
        csbMetodo       CONSTANT VARCHAR2(105) := csbSP_NAME || '.prFinCadenaJobsPERSCA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 

        sbSubject       VARCHAR2(2000);
        sbMessage0      VARCHAR2(4000); 
        
        nuTotal         NUMBER;
        nuCantiReg      NUMBER;                 
                                             
        CURSOR culdc_Proceso
        (
            inuProcesId LDC_PROCESO.PROCESO_ID%TYPE
        )
        IS
        SELECT LP.*
        FROM LDC_PROCESO LP
        WHERE LP.PROCESO_ID = inuProcesId;

        rcldc_Proceso          culdc_Proceso%ROWTYPE;
        
        sbParametrosPersca      VARCHAR2(2000);        
                   
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        OPEN culdc_Proceso(inuProceso);
        FETCH culdc_Proceso INTO rcldc_Proceso;
        CLOSE culdc_Proceso;
        
        sbRecipients := rcldc_Proceso.EMAIL;
                           
        /******************************* Verifica si el proceso terminó *************************/
        LDC_PKGENEORDEAUTORECO.prcTotales
        (
            isbProgram,
            nuTotal,
            nuCantiReg
        );

        -- Una vez el proceso haya terminado, se envía correo
        sbSubject  := 'Finaliza ' || isbProgram || ' - PROCESO ' || rcldc_Proceso.PROCESO_DESCRIPCION  ||
                    '---> Fecha: ' ||
                    to_char(sysdate, 'dd/mm/yyyy HH:MI:SS am');
                    
        sbParametrosPersca:= ' proceso >>>> :' || inuProceso ||chr(10) ||
                        ' ciclo >>>> :' || inuCICLO ||chr(10) ||
                        ' Departamento >>>> :' || inuDepartamento ||chr(10) ||
                        ' Localidad >>>> :' ||inuLocalidad || chr(10) || ' ';
                                            
        sbMessage0 :=   'Se Termino con exito el proceso de generacion del archivo de usuarios ' ||
                        'que se utilizara para generar ordenes de persecucion para ' ||
                        sbParametrosPersca ||
                        ' Total Registros procesados : ' || nuTotal || chr(10) ||
                        ' Total nuevos Registros para persecucion ' || nuCantiReg || chr(10);

        sbMessage0 := sbMessage0 || ' ' || chr(10) || ' ' || chr(10) || ' ' ||chr(10);

        pkg_Correo.prcEnviaCorreo( sbRecipients, sbSubject, sbMessage0);

        COMMIT;
          
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);      
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prFinCadenaJobsPERSCA;
    
    PROCEDURE prcargatbProcesosAutomaticos
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'prcargatbProcesosAutomaticos';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('tbProcesosAutomaticos.COUNT|' || tbProcesosAutomaticos.COUNT, csbNivelTraza);                

        IF tbProcesosAutomaticos.COUNT = 0 THEN
        
            OPEN cuProcesosAutomaticos;
            FETCH cuProcesosAutomaticos BULK COLLECT INTO tbProcesosAutomaticos;   
            CLOSE cuProcesosAutomaticos;
            
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;    
    END prcargatbProcesosAutomaticos;   

    PROCEDURE pCargTblProgCadJobsPERSCAAutom( inuTotalHilos NUMBER ) IS

        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCargTblProgCadJobsPERSCAAutom';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        rcPrograma      pkg_Scheduler.tyrcPrograma;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        prcargatbProcesosAutomaticos;

        tbSchedChainProg.DELETE;

        FOR indtbPA IN 1..tbProcesosAutomaticos.COUNT LOOP
        
            rcPrograma.PROGRAM_NAME     := 'INI_' || gsbProgramAuto || '_' || indtbPA;
            rcPrograma.PACKAGE          := UPPER('LDC_PKGENEORDEAUTORECO');
            rcPrograma.API              := UPPER('prIniCadenaJobsPERSCA');
            rcPrograma.PROGRAM_TYPE     := 'STORED_PROCEDURE';
            rcPrograma.STEP             := 'INI_' || gsbProgramAuto || '_' || indtbPA;
            rcPrograma.BLOQUEPL         := NULL;
            rcPrograma.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( rcPrograma.PACKAGE , rcPrograma.API  , rcPrograma.PROGRAM_TYPE, rcPrograma.BLOQUEPL );

            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  rcPrograma;

            FOR IND IN 1..inuTotalHilos LOOP

                rcPrograma.PROGRAM_NAME := gsbProgramAuto || '_' || indtbPA || '_' || IND;
                rcPrograma.PACKAGE      := UPPER('LDC_PKGENEORDEAUTORECO');
                rcPrograma.API          := UPPER('progeneraPersca');
                rcPrograma.PROGRAM_TYPE := 'STORED_PROCEDURE';
                rcPrograma.BLOQUEPL     := NULL;
                rcPrograma.STEP         := gsbProgramAuto || '_' || indtbPA || '_' || IND;
                rcPrograma.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( rcPrograma.PACKAGE , rcPrograma.API  , rcPrograma.PROGRAM_TYPE, rcPrograma.BLOQUEPL );

                tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  rcPrograma;

            END LOOP;

            rcPrograma.PROGRAM_NAME     := 'FIN_' || gsbProgramAuto ||  '_' || indtbPA;
            rcPrograma.PACKAGE          := UPPER('LDC_PKGENEORDEAUTORECO');
            rcPrograma.API              := UPPER('prFinCadenaJobsPERSCA');
            rcPrograma.PROGRAM_TYPE     := 'STORED_PROCEDURE';
            rcPrograma.STEP             := 'FIN_' || gsbProgramAuto || '_' || indtbPA;
            rcPrograma.BLOQUEPL         := NULL;

            rcPrograma.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( rcPrograma.PACKAGE , rcPrograma.API  , rcPrograma.PROGRAM_TYPE, rcPrograma.BLOQUEPL );

            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  rcPrograma;

        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pCargTblProgCadJobsPERSCAAutom;
    
	PROCEDURE pCreaReglCadJobsPERSCAAutom(inuTotalHilos NUMBER)
	IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaReglCadJobsPERSCAAutom';

		sbCondicion     VARCHAR2(4000);
		sbAccion        VARCHAR2(4000);

		nuError         NUMBER;
		sbError         VARCHAR2(4000);
		
	BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcargatbProcesosAutomaticos;

        FOR indtbPA IN 1..tbProcesosAutomaticos.COUNT LOOP

            pkg_traza.trace('indtbPA|'|| indtbPA, csbNivelTraza);
                
            IF indtbPA = 1 THEN
            
                sbCondicion := 'FALSE';
                sbAccion   := 'start INI_' || gsbProgramAuto || '_' || indtbPA;

                pkg_scheduler.define_chain_rule
                (
                   gsbChainJobsPERSCAAutom,
                   sbCondicion,
                   sbAccion
                );
                                        
            END IF;

            sbCondicion := REPLACE(sbAccion,'start ','');
            sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
            sbCondicion := sbCondicion || ' succeeded';

            sbAccion    := 'start ';

            FOR IND0 IN 1..inuTotalHilos LOOP

                sbAccion   := sbAccion || gsbProgramAuto || '_' || indtbPA || '_' || IND0 ;

                IF IND0 < inuTotalHilos THEN
                    sbAccion := sbAccion ||  ',';
                END IF;

            END LOOP;

            pkg_scheduler.define_chain_rule
            (
               gsbChainJobsPERSCAAutom,
               sbCondicion,
               sbAccion
            );

            sbCondicion := REPLACE(sbAccion,'start ','');
            sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
            sbCondicion := sbCondicion || ' succeeded';

            sbAccion := 'start FIN_' || gsbProgramAuto || '_' || indtbPA;

            pkg_scheduler.define_chain_rule
            (
               gsbChainJobsPERSCAAutom,
               sbCondicion,
               sbACCION
            );            
            

            pkg_traza.trace('tbProcesosAutomaticos.count|'||tbProcesosAutomaticos.count, csbNivelTraza);
            
            IF indtbPA = tbProcesosAutomaticos.count THEN
            
                sbCondicion := REPLACE(sbAccion,'start ','');
                sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
                sbCondicion := sbCondicion || ' succeeded';

                sbAccion := 'END';

                -- termina la cadena
                pkg_scheduler.define_chain_rule
                (
                   gsbChainJobsPERSCAAutom,
                   sbCondicion,
                   sbAccion
                );
                
            ELSE
            
                sbCondicion := REPLACE(sbAccion,'start ','');
                sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
                sbCondicion := sbCondicion || ' succeeded';

                sbAccion   := 'start INI_' || gsbProgramAuto || '_' || (indtbPA+1);

                pkg_scheduler.define_chain_rule
                (
                   gsbChainJobsPERSCAAutom,
                   sbCondicion,
                   sbAccion
                );           
            
            END IF;            
            
        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
	END pCreaReglCadJobsPERSCAAutom;        
    
    PROCEDURE pCreaCadenaJobsPERSCAAutom(inuTotalHilos NUMBER)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaCadenaJobsPERSCA';

        nuError NUMBER;
        sbError VARCHAR2(4000);

        tbArgumentos  pkg_Scheduler.tytbArgumentos;

        tbProgramas   pkg_scheduler.tytbProgramas;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCargTblProgCadJobsPERSCAAutom(inuTotalHilos);

        IF pkg_scheduler.FBLSCHEDCHAINEXISTS( gsbChainJobsPERSCAAutom ) THEN
            pkg_Traza.trace('Ya existe la cadena ' || gsbChainJobsPERSCAAutom, csbNivelTraza );

            tbProgramas := pkg_scheduler.ftbProgramas( gsbProgramAuto );
            
            pkg_Traza.trace('tbProgramas.Count|' || tbProgramas.Count );

            IF
            (
                NVL(tbProgramas.Count,0) <> tbProcesosAutomaticos.count*( inuTotalHilos + 2)
                OR
                pkg_scheduler.fblUltEjecCadJobConError(  gsbChainJobsPERSCAAutom )
            )
            THEN

                pkg_scheduler.pDropSchedChain( gsbChainJobsPERSCAAutom );

                pkg_scheduler.create_chain( gsbChainJobsPERSCAAutom );

            END IF;

        ELSE
            pkg_scheduler.create_chain( gsbChainJobsPERSCAAutom );
        END IF;

        FOR indtbPr IN 1..tbSchedChainProg.COUNT LOOP

            pkg_Traza.trace('paso|'|| tbSchedChainProg(indtbPr).step, csbNivelTraza );
            pkg_Traza.trace('programa|' || tbSchedChainProg(indtbPr).package || '.' || tbSchedChainProg(indtbPr).api,csbNivelTraza);

            tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN',tbSchedChainProg(indtbPr).package, tbSchedChainProg(indtbPr).api );

            pkg_Traza.trace('tbArgumentos.count|' || tbArgumentos.count,csbNivelTraza);

            pkg_scheduler.PCREASCHEDCHAINSTEP
            (
                gsbChainJobsPERSCAAutom,
                tbSchedChainProg(indtbPr).step,
                tbSchedChainProg(indtbPr).program_name,
                tbSchedChainProg(indtbPr).program_type,
                tbSchedChainProg(indtbPr).program_action,
                tbArgumentos.count,
                TRUE,
                gsbChainJobsPERSCAAutom,
                nuError,
                sbError
            );

            pkg_Traza.trace('Res pkg_scheduler.PCREASCHEDCHAINSTEP|' || sbError);

            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'pCreaSchedChainStep|' || sbError );
            END IF;

        END LOOP;

        pCreaReglCadJobsPERSCAAutom(inuTotalHilos);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pCreaCadenaJobsPERSCAAutom;
    
    PROCEDURE pDefValArgsCadJobsPERSCAAutom( inuTotalHilos NUMBER )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pDefValArgsCadJobsPERSCAAutom';
        tbArgumentos              pkg_Scheduler.tytbArgumentos;
        sbIndArg            VARCHAR2(100);
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        sbProgram           estaprog.esprprog%TYPE;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prcargatbProcesosAutomaticos;  
        
        FOR indtbPA IN 1..tbProcesosAutomaticos.COUNT LOOP        
        
            sbProgram := 'PERSCA_'||sqesprprog.nextval;
            
            tbArgumentos.delete;

            tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN', 'LDC_PKGENEORDEAUTORECO', UPPER('prIniCadenaJobsPERSCA'));

            tbArgumentos(UPPER('isbProgram')).VALUE         := sbProgram;        
            tbArgumentos(UPPER('inuProceso')).VALUE         := tbProcesosAutomaticos(indtbPA).proceso_id;
            tbArgumentos(UPPER('inuCICLO')).VALUE           := -1;        
            tbArgumentos(UPPER('inuDepartamento')).VALUE    := -1;
            tbArgumentos(UPPER('inuLocalidad')).VALUE       := -1;
            tbArgumentos(UPPER('inuLogProcessId')).VALUE    := NULL;

            sbStep := 'INI_' || gsbProgramAuto || '_'|| indtbPA;

            pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

            sbIndArg := tbArgumentos.First;

            LOOP

                EXIT WHEN sbIndArg IS NULL;

                pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

                pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

                pkg_scheduler.define_program_argument
                (
                    sbStep,
                    tbArgumentos(sbIndArg).position,
                    tbArgumentos(sbIndArg).argument_name,
                    tbArgumentos(sbIndArg).data_type,
                    tbArgumentos(sbIndArg).value,
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );

                ELSE
                    pkg_Traza.trace( 'OK Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name , csbNivelTraza);
                END IF;

                sbIndArg := tbArgumentos.Next(sbIndArg );

            END LOOP;
            
            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;            
            
            tbArgumentos.Delete;        

            tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN','LDC_PKGENEORDEAUTORECO', UPPER('progeneraPersca'));
                              
            tbArgumentos(UPPER('isbProgram')).VALUE         := sbProgram;
            tbArgumentos(UPPER('inuProceso')).VALUE         := tbProcesosAutomaticos(indtbPA).proceso_id;
            tbArgumentos(UPPER('inuCiclo')).VALUE           := -1;        
            tbArgumentos(UPPER('inuDepartamento')).VALUE    := -1;
            tbArgumentos(UPPER('inuLocalidad')).VALUE       := -1;
            tbArgumentos(UPPER('inuTotalHilos')).VALUE      := inuTotalHilos;

            FOR nuHilo in 1..inuTotalHilos LOOP

                tbArgumentos('INUHILO').VALUE := nuHilo;

                sbStep := gsbProgramAuto || '_' || indtbPA || '_' || nuHilo;

                pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

                sbIndArg := tbArgumentos.First;

                LOOP

                    EXIT WHEN sbIndArg IS NULL;

                    pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

                    pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
                    pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
                    pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
                    pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

                    pkg_scheduler.define_program_argument
                    (
                        sbStep,
                        tbArgumentos(sbIndArg).position,
                        tbArgumentos(sbIndArg).argument_name,
                        tbArgumentos(sbIndArg).data_type,
                        tbArgumentos(sbIndArg).value,
                        nuError,
                        sbError
                    );

                    IF nuError <> 0 THEN
                        pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );
                    ELSE
                        pkg_Traza.trace( 'OK Creacion el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name, csbNivelTraza );
                    END IF;

                    sbIndArg := tbArgumentos.Next(sbIndArg );

                END LOOP;

                pkg_scheduler.enable
                (
                    sbStep,
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
                ELSE
                    pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
                END IF;

            END LOOP;

            tbArgumentos.delete;

            tbArgumentos := pkg_Scheduler.ftbArgumentos( 'OPEN','LDC_PKGENEORDEAUTORECO', UPPER('prFinCadenaJobsPERSCA'));

            tbArgumentos(UPPER('isbProgram')).VALUE         := sbProgram;
            tbArgumentos(UPPER('inuProceso')).VALUE         := tbProcesosAutomaticos(indtbPA).proceso_id;
            tbArgumentos(UPPER('inuCiclo')).VALUE            := -1;        
            tbArgumentos(UPPER('inuDepartamento')).VALUE     := -1;
            tbArgumentos(UPPER('inuLocalidad')).VALUE        := -1;
            tbArgumentos(UPPER('inuTotalHilos')).VALUE      := inuTotalHilos;

            sbStep := 'FIN_' || gsbProgramAuto || '_' || indtbPA;

            pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

            sbIndArg := tbArgumentos.First;

            LOOP

                EXIT WHEN sbIndArg IS NULL;

                pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

                pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

                pkg_scheduler.define_program_argument
                (
                    sbStep,
                    tbArgumentos(sbIndArg).position,
                    tbArgumentos(sbIndArg).argument_name,
                    tbArgumentos(sbIndArg).data_type,
                    tbArgumentos(sbIndArg).value,
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );

                ELSE
                    pkg_Traza.trace( 'OK Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name , csbNivelTraza);
                END IF;

                sbIndArg := tbArgumentos.Next(sbIndArg );

            END LOOP;
            
            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;            

        END LOOP;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pDefValArgsCadJobsPERSCAAutom;

    PROCEDURE pActivaCadenaJobsPERSCAAutom
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pActivaCadenaJobsPERSCAAutom';
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        prcargatbProcesosAutomaticos;  
        
        pkg_scheduler.enable
        (
            gsbChainJobsPERSCAAutom,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando la cadena ' || gsbChainJobsPERSCAAutom );
        ELSE
            pkg_Traza.trace( 'OK Habilitando la cadena ' || gsbChainJobsPERSCAAutom, csbNivelTraza );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pActivaCadenaJobsPERSCAAutom;   
      
    -- Genera la cadena de Jobs de PERSCA
    PROCEDURE prgeneraPerscaCadJobsAutom
    IS
        csbMetodo       CONSTANT VARCHAR2(105) := csbSP_NAME || '.prgeneraPerscaCadJobsAutom';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
             
        sbMessage0      VARCHAR2(2000);
        
        sbProgram       VARCHAR2(2000);
        
        nuTotalHilos    NUMBER;
                
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        IF ( TO_NUMBER(TO_CHAR(SYSDATE,'DD')) > 1 ) THEN
                    
            tbProcesosAutomaticos.Delete;
            
            prcargatbProcesosAutomaticos;        

            nuTotalHilos := nvl(pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_NUM_HILOS_PERSCA'),1);
                                                                            
            IF pkg_scheduler.fblSchedChainRunning( gsbChainJobsPERSCAAutom ) THEN
                    
                FOR indtbPA IN 1..tbProcesosAutomaticos.COUNT LOOP
                
                    sbProgram :=    tbProcesosAutomaticos(indtbPA).proceso_id || '-' ||
                                    tbProcesosAutomaticos(indtbPA).proceso_descripcion;
            
                    sbMessage0 := 'No se pudo ejecutar ' || sbProgram || chr(10) ||
                                fsbInfoPerscaEnEjec;
                                                                                 
                    pkg_Correo.prcEnviaCorreo
                    (  
                        tbProcesosAutomaticos(indtbPA).email,
                        'No se pudo ejecutar PERSCA automaticamente porque existe otro proceso en ejecución ',
                        sbMessage0       
                    );
                    
                END LOOP;
                
            ELSE

                pCreaCadenaJobsPERSCAAutom(nuTotalHilos);

                pDefValArgsCadJobsPERSCAAutom
                (    
                    nuTotalHilos            
                 );

                pActivaCadenaJobsPERSCAAutom;

                pkg_scheduler.run_chain(gsbChainJobsPERSCAAutom , 'INI_' || gsbProgramAuto || '_1', 'JOB_' || gsbChainJobsPERSCAAutom );

            END IF;
         
        ELSE
            pkg_traza.trace( 'No se puede ejecutar PERSCA el dia 1 del mes', csbNivelTraza );
        END IF;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
             
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);                    
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );                                                            
            FOR indtbPA IN 1..tbProcesosAutomaticos.COUNT LOOP
            
                sbProgram :=    tbProcesosAutomaticos(indtbPA).proceso_id || '-' ||
                                tbProcesosAutomaticos(indtbPA).proceso_descripcion;
        
                sbMessage0 := 'No se pudo ejecutar PERSCA automaticamente ' || sbProgram || chr(10) ||
                              '[' || sbError || ']' ;
                                                                             
                pkg_Correo.prcEnviaCorreo
                (
                    tbProcesosAutomaticos(indtbPA).email,
                    sbMessage0,
                    sbMessage0       
                );
                
            END LOOP;       
            RAISE pkg_error.Controlled_Error;
            
        WHEN OTHERS THEN        
            pkg_error.setError;              
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_traza.trace('sbError :' || sbError, csbNivelTraza );

            FOR indtbPA IN 1..tbProcesosAutomaticos.COUNT LOOP
            
                sbProgram :=    tbProcesosAutomaticos(indtbPA).proceso_id || '-' ||
                                tbProcesosAutomaticos(indtbPA).proceso_descripcion;
                
                sbMessage0 := 'No se pudo ejecutar PERSCA automaticamente ' || sbProgram || chr(10) ||
                              '[' || sbError || ']' ;
                                                                             
                pkg_Correo.prcEnviaCorreo
                (
                    tbProcesosAutomaticos(indtbPA).email,
                    sbMessage0,
                    sbMessage0       
                );
                
            END LOOP;
            RAISE pkg_error.Controlled_Error;
            
    END prgeneraPerscaCadJobsAutom;
                          	    											
END LDC_PKGENEORDEAUTORECO;
/

