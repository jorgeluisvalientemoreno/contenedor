CREATE OR REPLACE PROCEDURE LDC_ANUORDENESRUTEROCRM AS
    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  LDC_anuOrdenesRutero
    Descripcion :  Procedimiento que anula las ordenes generadas de ruteros que
                   hallan pasado un tiempo (parametrizable) si ser legalizadas
    Autor       : Llozada
    Fecha       : 30-10-2014

    Historia de Modificaciones
    Fecha               Autor              Modificacion
    =========           =========          ====================
    26/06/2024          jpinedc             OSF-2606: * Se usa pkg_Correo
                                            * Ajustes por estándares
    **************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_ANUORDENESRUTEROCRM';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);      
        
    CURSOR cuOrdSinLega(nuDiasPasados in number) IS
    select a.order_id, b.created_date
      from ldc_loteruteroscrm a, or_order b
     where b.order_id =  a.order_id
       and order_status_id in (or_boconstants.cnuORDER_STAT_ASSIGNED, or_boconstants.cnuORDER_STAT_REGISTERED)
       and ((sysdate - created_date) > nuDiasPasados);

    nuDiasPast          number;
    nuCausalAnu         ge_causal.causal_id%type;
    sbDirLog            ld_parameter.value_chain%type;
    rcOrderComment      daor_order_comment.styOR_order_comment;
    isbComment          or_order_comment.order_comment%type;
    sbFileManagement    pkg_gestionArchivos.styArchivo;
    cnuCommentType      constant number  := 83;
    onuErrorCode        number(18);
    nuCancelledOrders   number := 0;
    sbTimeProc          varchar2(500);
    sbNameFile          varchar2(500);
    sbNameFileinco      varchar2(500);
    sbMessageLog        varchar2(2000);
    osbErrorMessage     varchar2(2000);
    sbordenes           varchar2(2000) default null;
    nuconta             number(8);
    ----------------------------------------------------------------------------
    -- Variables para el Correo
    ----------------------------------------------------------------------------
    sbE_MAIL                varchar2(2000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_EMAIL_RUTEROSCRM');
    sbAsunto                varchar2(2000) := 'ANULACION DE ORDENES DE RUTEROSCRM';
    sbAsuntoinco            varchar2(2000) := 'ANULACION DE ORDENES DE RUTEROSCRM - INCONSISTENTES';
    sbMensaje               varchar2(2000) := 'Ordenes que no se lograron anular mediante el JOB de anulación: ';
    sbordenescor            varchar2(2000) default null;
    sblote                  varchar2(2000) default null;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

    /* Se obtiene directorio para generacion de log */
    sbDirLog := pkg_BCLD_Parameter.fsbObtieneValorCadena('DIR_ANUL_ORD_RUTERO');

    /* Se construye nombre del archivo */
    sbNameFileinco := 'INCONSIS_'||sbTimeProc||'.LOG';

    /* Crea archivo Log */
    sbFileManagement := pkg_gestionArchivos.ftAbrirArchivo_SMF(sbDirLog, sbNameFileinco, 'w');

    /* Se obtiene numero de dias de vencimiento de ejecucion ordenes*/
    nuDiasPast := pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUMERO_DIAS_ANUL_RUTCRM');

    /*Se obtiene causal para cerrar orden de rutero*/
    nuCausalAnu := pkg_BCLD_Parameter.fnuObtieneValorNumerico('CAUSAL_ANUL_RUTEROCRM');

    rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
    rcOrderComment.comment_type_id := -1;
    isbComment := 'Orden anulada por vencimiento en la ejecución...';

    sbMessageLog  := 'INICIO DE ANULACION DE ORDENES DE RUTEROCRM ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');

    pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, 'Ordenes inconsistentes...');
    sbordenes := NULL;
    FOR i in cuOrdSinLega(nuDiasPast)  LOOP

        LDC_CANCEL_ORDER(i.order_id,nuCausalAnu, isbComment, cnuCommentType, onuErrorCode, osbErrorMessage);

        if nvl(onuErrorCode,-1) <> 0 then

            sbMessageLog := 'Error: no se pudo anular la orden '||i.order_id||' - causa: '||osbErrorMessage;
            pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbMessageLog);
            rollback;
            continue;

        else
            IF sbordenes IS NULL THEN
              sbordenes := ','||TO_CHAR(i.order_id);
            ELSE
              sbordenes := sbordenes||','||to_char(i.order_id);
            END IF;
            commit;
            nuCancelledOrders := nuCancelledOrders + 1;
        end if;
    END LOOP;
    pkg_gestionArchivos.prcCerrarArchivo_SMF(sbFileManagement);
    sbordenes := sbordenes||',';
    FOR h IN (SELECT c.correo,count(1) FROM ldc_loteruteroscrm c WHERE sbordenes LIKE '%,'||c.order_id||',%' AND correo is not null GROUP BY correo) LOOP
        sbordenescor := NULL;
        sblote       := NULL;
        nuconta      := 0;
        FOR i IN (SELECT c.lote_id,c.order_id,c.correo FROM ldc_loteruteroscrm c WHERE sbordenes LIKE '%,'||c.order_id||',%' AND correo = h.correo) LOOP
            sblote := to_char(i.lote_id);
            sbE_MAIL := i.correo;
            IF sbordenescor IS NULL THEN
                sbordenescor := i.order_id||' - '||sblote;
            ELSE
                sbordenescor := sbordenescor||','||CHR(13)||i.order_id||' - '||sblote;
            END IF;
            nuconta := nuconta + 1;
        END LOOP;
     
        -- Obtenemos el tiempo
        sbTimeProc := to_char(sysdate, 'yyyymmdd_hh24miss');
        --   Se construye nombre del archivo
        sbNameFile := 'AN_RUTCRM_'||sbTimeProc||'.LOG';
        -- Crea archivo Log
        sbFileManagement := pkg_gestionArchivos.ftAbrirArchivo_SMF(sbDirLog, sbNameFile, 'w');
        -- Datos archivo
        pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, 'Se anularon las siguientes ordenes : ');
        pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbordenescor);
        sbMessageLog  := 'CANTIDAD DE ORDENES ANULADAS: ' || nuconta;
        pkg_gestionArchivos.prcEscribirLinea_SMF(sbFileManagement, sbMessageLog);
        -- Cerramos el archivo
        pkg_gestionArchivos.prcCerrarArchivo_SMF(sbFileManagement);

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => lower(sbE_MAIL),
            isbAsunto           => sbAsunto,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbDirLog || '/' || sbNameFile
        );      

        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => lower(sbE_MAIL),
            isbAsunto           => sbAsuntoinco,
            isbMensaje          => sbMensaje,
            isbArchivos         => sbDirLog || '/' || sbNameFileINCO
        );   
      
    END LOOP;

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
END LDC_ANUORDENESRUTEROCRM;
/

GRANT EXECUTE on LDC_ANUORDENESRUTEROCRM to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_ANUORDENESRUTEROCRM to REXEOPEN;
/

