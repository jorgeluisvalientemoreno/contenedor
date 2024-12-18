CREATE OR REPLACE PROCEDURE LDCAMOTA
(
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE
)
IS
    /***************************************************************************
        Propiedad intelectual de Gases del Caribe S.A (c).
        Unidad         : LDCAMOTA
        Descripcion    : Procedimiento ejecuta el proceso del PB Programable
                         LDCAMOTA - Anulacion de Ordenes de Trabajo por Archivo  
        Autor          : Lubin Pineda
        Fecha          : 11/11/2022
        Historia de Modificaciones
            DD-MM-YYYY      <Autor>.                Modificacion
            -----------     -------------------     ----------------------------
            11-11-2022      Lubin Pineda - MVM      Creacion
            21-03-2024      Lubin Pineda - MVM      OSF-2378: 
                                                    * Se usa pkg_gestionArchivos
                                                    * Nuevos directrices programación
    ***************************************************************************/

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= 'LDCAMOTA.';
    cnuNIVEL_TRAZA    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
            
    gsbDirectorio           ge_directory.path%TYPE;
    gflArchivoIn            pkg_gestionArchivos.styArchivo;
    gsbNombreArchivoIn      VARCHAR2(1000);
    gflArchivoOut           pkg_gestionArchivos.styArchivo;
    
    gnuTipoTrabajo          or_order.task_type_id%TYPE;
    gnuCausalAnulacion      or_order.causal_id%TYPE;
    gsbOrderComme           or_order_comment.order_comment%TYPE;
    
    grcOrden                DAOR_Order.styOr_Order;
    
    exEstado_Invalido       EXCEPTION;
    exTipoTarea_Invalido    EXCEPTION;
    exOrden_Alfanumerica    EXCEPTION;
    
    gnuYear                 NUMBER (4);
    gnuMonth                NUMBER (2);
    gnuSessionId            NUMBER;
    gsbDBUser               VARCHAR2 (30);
    gnuHilos                NUMBER := 1;
    gnuLogProceso           ge_log_process.log_process_id%TYPE;

    -- Contadores
    gnuRegProcOk            NUMBER (10) DEFAULT 0;
    gnuRegProcNoOk          NUMBER (10) DEFAULT 0;
    gnuRegArchivo           NUMBER (10) DEFAULT 0;
    
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);

    sbproceso  VARCHAR2(100)  := csbSP_NAME ||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
            
    PROCEDURE pAbreArchivoTraza

    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pAbreArchivoTraza';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        sbnomarchres    VARCHAR2 (100);            
        sbEncabezado    VARCHAR2(1000) := 'Orden|Estado_Inicial|Progama|Resultado';
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);  
        
        sbnomarchres := SUBSTR( gsbNombreArchivoIn,1, INSTR( gsbNombreArchivoIn, '.') - 1 ) || '.log';
                        
        IF not pkg_gestionArchivos.fblArchivoAbierto_SMF( gflArchivoOut ) THEN
            gflArchivoOut := pkg_gestionArchivos.ftAbrirArchivo_SMF (gsbDirectorio, sbnomarchres, 'W');
            pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, 'Inicio Proceso|' || TO_CHAR(sysdate, 'DD/MM/YYYY HH24:MI:SS'), TRUE );
            pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, sbEncabezado, TRUE );
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            RAISE pkg_error.Controlled_Error;           
    END pAbreArchivoTraza;
    
    PROCEDURE pEscribeTraza
    (
        isbLinea        varchar2, 
        inuEstado       or_order.order_status_id%TYPE,
        isbPrograma     VARCHAR2,
        isbMensaje      VARCHAR2
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pEscribeTraza';
            
        sbLineaO    VARCHAR2(32000) := isbLinea || '|' || inuEstado || '|' || isbPrograma || '|' || isbMensaje;
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
            
        pkg_Traza.trace('    isbLinea|' || isbLinea, cnuNIVEL_TRAZA );
        pkg_Traza.trace('    inuEstado|' || inuEstado, cnuNIVEL_TRAZA );
        pkg_Traza.trace('    isbPrograma|' || isbPrograma, cnuNIVEL_TRAZA );
        pkg_Traza.trace('    isbMensaje|' || isbMensaje, cnuNIVEL_TRAZA );

        pAbreArchivoTraza;
        
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, sbLineaO, TRUE );
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);      
                    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );            
            RAISE pkg_error.Controlled_Error;
    END pEscribeTraza;    
            
    PROCEDURE pInicia
    IS
                
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pInicia';
            
        -- Lista de parametros con los que se programo el proceso
        sbParametros            ge_process_schedule.parameters_%TYPE;
        
        nuIdDirectorio          ge_directory.directory_id%TYPE;
                                
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
                                    
        -- Obtiene datos basicos
        gnuYear         := TO_CHAR (SYSDATE, 'YYYY');        
        gnuMonth        := TO_CHAR (SYSDATE, 'MM');        
        gnuSessionId    := pkg_Session.fnuGetSesion;        
        gsbDBUser       := pkg_Session.getUser;

        pkg_Traza.trace('    gnuSessionId|' || gnuSessionId, cnuNIVEL_TRAZA );
        pkg_Traza.trace('    gsbDBUser|' || gsbDBUser, cnuNIVEL_TRAZA );
                
        -- se obtiene parametros
        sbParametros := dage_process_schedule.fsbgetparameters_ (inuProgramacion);

        nuIdDirectorio      := TRIM (ut_string.getparametervalue (sbParametros, 'PATH', '|', '='));
                
        gsbDirectorio       := pkg_BCDirectorios.fsbGetRuta ( nuIdDirectorio );
        
        gsbNombreArchivoIn  := TRIM (ut_string.getparametervalue (sbParametros, 'HIREARCH', '|', '='));
        
        gnuTipoTrabajo      := TRIM (ut_string.getparametervalue (sbParametros, 'TASK_TYPE_ID', '|', '='));
        
        gnuCausalAnulacion  := TRIM (ut_string.getparametervalue (sbParametros, 'CAUSAL_ID', '|', '='));
        
        gsbOrderComme       := TRIM (ut_string.getparametervalue (sbParametros, 'ORDER_COMMENT', '|', '='));
               
        pAbreArchivoTraza;
        
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);
        
                                
        -- Se adiciona al log de procesos
        ge_boschedule.AddLogToScheduleProcess (inuProgramacion,
                                               gnuHilos,
                                               gnuLogProceso);

        pkg_Traza.trace('    gnuLogProceso|' || gnuLogProceso, cnuNIVEL_TRAZA );
        
        COMMIT;
                                               
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);                                         
                                                                                              
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );            
            RAISE pkg_error.Controlled_Error;
    END pInicia;

         
    PROCEDURE pAbreArchivoEntrada
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pAbreArchivoEntrada';              
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);

        pkg_Traza.trace('    gsbDirectorio|' || gsbDirectorio, cnuNIVEL_TRAZA );
        pkg_Traza.trace('    gsbNombreArchivoIn|' || gsbNombreArchivoIn, cnuNIVEL_TRAZA );

        IF NOT pkg_gestionArchivos.fblArchivoAbierto_SMF( gflArchivoIn ) THEN
                
            gflArchivoIn := pkg_gestionArchivos.ftAbrirArchivo_SMF (gsbDirectorio, gsbNombreArchivoIn, 'R');
        
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );            
            RAISE pkg_error.Controlled_Error;  
    END pAbreArchivoEntrada;
    
       
    PROCEDURE pCierraArchivo( iflArchivo IN OUT pkg_gestionArchivos.styArchivo)
    IS 
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pCierraArchivo';      
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
    
        IF pkg_gestionArchivos.fblArchivoAbierto_SMF( iflArchivo ) THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF( iflArchivo );
        END IF;

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN); 
                       
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );            
            RAISE pkg_error.Controlled_Error;      
    END pCierraArchivo;
    
    PROCEDURE pEscribeResumen
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pEscribeResumen';     
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
    
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, 'Cantidad Registros|' || gnuRegArchivo , TRUE);
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, 'Cantidad Procesados OK|' || gnuRegProcOk  , TRUE);                
        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, 'Cantidad Procesados Error|' || gnuRegProcNoOk, TRUE);

        pkg_gestionArchivos.prcEscribirLinea_SMF( gflArchivoOut, 'Finaliza Proceso|' || TO_CHAR(sysdate, 'DD/MM/YYYY HH24:MI:SS'), TRUE );
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);       

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );            
            RAISE pkg_error.Controlled_Error;  
    END pEscribeResumen;
    
    PROCEDURE pCierraArchivos
    IS 
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pCierraArchivos';       
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
            
        pCierraArchivo( gflArchivoIn );
        
        pEscribeResumen;
    
        pCierraArchivo( gflArchivoOut );
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);       
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza( null, null, csbMetodo , sbError );            
            RAISE pkg_error.Controlled_Error;       
    END pCierraArchivos;
    
    PROCEDURE pValidaOrden( isbLinea    VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pValidaOrden';                    
        cnuREGISTRADA           CONSTANT or_order.order_status_id%TYPE := 0;
        cnuASIGNADA             CONSTANT or_order.order_status_id%TYPE := 5;
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
        
        grcOrden    := NULL; 
        
        IF LDC_BOUTILITIES.IS_NUMBER( isbLinea ) = 'Y' then
            
            -- Valida que la orden exista
            grcOrden := pkg_BCOrdenes.frcGetRecord( isbLinea );
            
            -- Valida que la orden este en estado Registrada(0) o Asignada(5)
            IF grcOrden.Order_Status_Id NOT IN ( cnuREGISTRADA, cnuASIGNADA ) THEN
                RAISE exEstado_Invalido;
            END IF;

            -- Valida que la orden sea del tipo de trabajo especificado
            IF grcOrden.Task_Type_Id NOT IN ( gnuTipoTrabajo ) THEN
                RAISE exTipoTarea_Invalido;    
            END IF;
            
        ELSE
            RAISE exOrden_Alfanumerica; 
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);      
            
    END pValidaOrden;
    
    PROCEDURE pAnulaOrden
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pAnulaOrden';   
                
        cnuCommentType  or_order_comment.comment_type_id%TYPE := 1277;    
            
        nuErrorCode         NUMBER;
        sbErrorMesse        VARCHAR(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
            
        -- Anula la orden
        API_ANULLORDER(grcOrden.Order_Id, cnuCommentType, gsbOrderComme, nuErrorCode, sbErrorMesse );
		
        IF nuErrorCode = pkConstante.Exito THEN
           
            -- Actualiza la causal escogida
            pkg_OR_Order.prc_ActualizaCausalOrden(grcOrden.Order_Id, gnuCausalAnulacion,nuErrorCode, sbErrorMesse);

            IF nuErrorCode = pkConstante.Exito THEN
                COMMIT;
                gnuRegProcOk   := gnuRegProcOk + 1;                
                pEscribeTraza(grcOrden.Order_Id, grcOrden.Order_Status_Id, csbMetodo,  'Ok');
            ELSE
               ROLLBACK;
               gnuRegProcNoOk    := gnuRegProcNoOk + 1;
               pEscribeTraza(grcOrden.Order_Id, grcOrden.Order_Status_Id, csbMetodo, 'Error prc_ActualizaCausalOrden ' || sbErrorMesse );                      
            END IF;
                    
        ELSE
           ROLLBACK;
           gnuRegProcNoOk    := gnuRegProcNoOk + 1;
           pEscribeTraza(grcOrden.Order_Id, grcOrden.Order_Status_Id, csbMetodo, 'Error API_ANULLORDER ' || sbErrorMesse );                      
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);      
                        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(grcOrden.Order_Id, grcOrden.Order_Status_Id, csbMetodo, sbError); 
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(grcOrden.Order_Id, grcOrden.Order_Status_Id, csbMetodo, sbError);             
            RAISE pkg_error.Controlled_Error;         
    END pAnulaOrden;
        
    PROCEDURE pProcesaLineaIn( isbLinea VARCHAR2)
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pProcesaLineaIn'; 
                                
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
            
        pValidaOrden( isbLinea );
        
        pAnulaOrden;
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);
                
        EXCEPTION
            WHEN exOrden_Alfanumerica THEN
                pEscribeTraza( isbLinea , NULL,csbMetodo, 'El id de la orden es alfanumerico' );
                gnuRegProcNoOk    := gnuRegProcNoOk + 1;
            WHEN exEstado_Invalido THEN        
                pEscribeTraza( grcOrden.Order_Id , grcOrden.Order_Status_Id,csbMetodo, 'El estado de la orden no es 0 ni 5' );
                gnuRegProcNoOk    := gnuRegProcNoOk + 1;
            WHEN exTipoTarea_Invalido THEN
                pEscribeTraza( grcOrden.Order_Id, grcOrden.Order_Status_Id,csbMetodo, 'El tipo de trabajo no es ' || gnuTipoTrabajo );
                gnuRegProcNoOk    := gnuRegProcNoOk + 1;
            WHEN pkg_Error.CONTROLLED_ERROR then
                pkg_Error.getError( nuError, sbError );
                gnuRegProcNoOk    := gnuRegProcNoOk + 1;
                pEscribeTraza( isbLinea, grcOrden.Order_Status_Id, csbMetodo, 'Error Controlado [' || sbError || ']' );
            WHEN OTHERS THEN    
                pEscribeTraza( grcOrden.Order_Id, grcOrden.Order_Status_Id, csbMetodo, sqlerrm );
                gnuRegProcNoOk    := gnuRegProcNoOk + 1;
                ROLLBACK;                         
    END pProcesaLineaIn;
    
    PROCEDURE pProcesaArchivoIn
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pProcesaArchivoIn'; 
                    
        sbLineaIn               VARCHAR2(32000);
        
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);
    
        pAbreArchivoEntrada;
    
        LOOP
        
            sbLineaIn := NULL;

            BEGIN
                
                sbLineaIn := pkg_gestionArchivos.fsbObtenerLinea_SMF (gflArchivoIn );
                gnuRegArchivo := gnuRegArchivo + 1;
                
                sbLineaIn := REPLACE( sbLineaIn, CHR(13) , '' );
                sbLineaIn := REPLACE( sbLineaIn, CHR(9) , '' );
                                
                pProcesaLineaIn( sbLineaIn );
                
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
            END;    
    
        END LOOP;
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);     
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(null, null , csbMetodo, sbError); 
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(null, null, csbMetodo, sbError);             
            RAISE pkg_error.Controlled_Error;         
    END pProcesaArchivoIn;
    
    PROCEDURE pFinaliza
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pFinaliza';     
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);

        pkg_Traza.trace('    gnuSessionId|' || gnuSessionId, cnuNIVEL_TRAZA ); 

        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso);
        
        pkg_Traza.trace('    gnuLogProceso|' || gnuLogProceso, cnuNIVEL_TRAZA ); 
                
        ge_boschedule.changelogProcessStatus (gnuLogProceso, 'F');
        
        pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN);    
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(null, null , csbMetodo, sbError); 
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(null, null, csbMetodo, sbError);             
            RAISE pkg_error.Controlled_Error; 
    END pFinaliza;   
    
BEGIN
    
    pkg_traza.trace(csbSP_NAME, cnuNIVEL_TRAZA, pkg_traza.csbINICIO);

    pInicia;
       
    pProcesaArchivoIn;
        
    pFinaliza;

    pCierraArchivos;

    pkg_traza.trace(csbSP_NAME, cnuNIVEL_TRAZA, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbSP_NAME, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(null, null , csbSP_NAME, sbError);
            ROLLBACK; 
            pCierraArchivos;
        WHEN OTHERS THEN
            pkg_traza.trace(csbSP_NAME, cnuNIVEL_TRAZA, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNIVEL_TRAZA );
            pEscribeTraza(null, null, csbSP_NAME, sbError);             
            ROLLBACK; 
            pCierraArchivos;
END LDCAMOTA;
/