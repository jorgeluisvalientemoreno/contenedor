CREATE OR REPLACE PROCEDURE adm_person.ldc_prlecturaval
IS
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe SA ESP">
        <Unidad>LDC_PRLECTURAVAL</Unidad>
        <Autor>Harrinson Henao Camelo - Horbath</Autor>
        <Fecha>21-02-2022</Fecha>
        <Descripcion> 
            PLUGIN de validacion de lectura de retiro en el proceso            
        </Descripcion>   
        <Historial>
            <Modificacion Autor="hahenao" Fecha="21-02-2022" Inc="CA875" Empresa="GDC">
                Creacion
            </Modificacion>
        </Historial>
            20/10/2022  dsaltarin           OSF-625: Se modifica la forma de calcular el consumo promedio
            12/01/2023  felipe.valencia     OSF-625: Se modifca por cambio de alcance y no tener en cuenta
                                             los consumos recuperados generados durante la legalización
                                             de orden de cambio de medidor
            16/08/2023  felipe.valencia     OSF-1421: Se modifica por estadares tecnicos
            15/05/20234 Adrianavg           OSF-2673: Se migra del esquema OPEN al esquema ADM_PERSON
    </Procedure> 
    **************************************************************************/
    --Constantes
    csbVersion  CONSTANT VARCHAR2(100) := 'OSF-2673';
    
    -- Para el control de traza:
    csbSP_NAME  CONSTANT VARCHAR2(100) := $$PLSQL_UNIT||'.';
    csbPUSH     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbPOP      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbPOP_ERC  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbPOP_ERR  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbLDC      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BO.
    cnuLEVELPUSHPOP             CONSTANT NUMBER := 1;
    cnuLEVEL                    CONSTANT NUMBER := 9;
    cnuGenericError             CONSTANT NUMBER := 2741;
    
    --Variables
    sbMethodName    VARCHAR2(50) := 'LDC_PRLECTURAVAL';
    nuOrderId       NUMBER;
    nuCausalId      NUMBER;
    nuTaskType      NUMBER;
    nuLectRetiro    NUMBER;
    nuUltiLect      NUMBER;
	dtFechaUltLect  DATE;
    nuNumIntentos   NUMBER;
    sbDatoAdicion   VARCHAR2(1);
    nuLectSuge      NUMBER;
    dtFechaEjec     DATE;
    nuNumDias       NUMBER;
    nuPeriConsact   NUMBER;
    dTfechFinal     DATE;
    nuano           NUMBER;
    numes           NUMBER;
    nuDiasConsActu  NUMBER;
    nuCicloCons     servsusc.sesucico%TYPE;
    nuLectSugGua    NUMBER;
    nusolicitud     NUMBER;
    nuperiactual    NUMBER;
    
    --Cursores
	CURSOR cugetLectSuge
    (
        inuSolicitud IN NUMBER
    ) 
    IS
        SELECT NUM_LECTSUGE
        FROM LDC_CTRLLECTURA
        WHERE ID_SOLICITUD = inuSolicitud;

    CURSOR cuObtienePerioAct
    (
        inupericose number
    )
    IS
        SELECT (pE.PECSFECF  - pe.PECSFECI) dias, pefaano, pefames
        FROM PERICOSE pe, perifact p
        WHERE pe.pecscico = p.pefacicl
        AND pe.pecscons = inupericose
        AND  pe.PECSFECF BETWEEN p.pefafimo AND p.pefaffmo
        AND PE.PECSCICO = nuCicloCons;

    CURSOR cuOrderActivity
    (
        inuOrderId      IN    or_order_activity.order_id%TYPE
    )
    IS
        SELECT  *
        FROM    or_order_activity
        WHERE ORDER_id = inuOrderId;

    CURSOR cuUltimaLectura
    (
        inuProductId        in  pr_product.product_id%TYPE
    )
    IS
        SELECT leemleto, leemfele
        FROM conssesu c2, lectelme l
        WHERE c2.cosssesu = inuproductid
		AND c2.cosspefa = leempefa
		AND leemsesu = c2.cosssesu
		AND leempecs = cosspecs
		AND c2.cossmecc = 1
		AND l.leemclec = 'F'
        AND cosspefa < nuperiactual
		AND c2.cossfere = ( SELECT MAX(C.cossfere)
							 FROM conssesu C
							WHERE C.cosssesu=c2.cosssesu
							  AND C.cosspefa=c2.cosspefa
							  AND C.cossmecc !=4)
        AND NOT EXISTS (
                            SELECT  NULL
                            FROM    cm_ordecrit, or_order 
                            WHERE   order_id = orcrorde
                            AND     order_status_id != 8
                            AND     orcrlect =leemcons
        )
        ORDER BY cossfere DESC;

    CURSOR cuLecturaAct
    (
        inuProductId        in  pr_product.product_id%TYPE,
        inuDocu             in  lectelme.leemdocu%TYPE
    )
    IS
        SELECT  LEEMLETO, leempefa, LEEMPECS
        FROM    lectelme
        WHERE   leemsesu = inuProductId
        AND     LEEMCLEC = 'R'
        AND     LEEMDOCU = inuDocu
        ORDER BY LEEMFELE DESC;

    CURSOR cuExisteRegistro
    (
        inuOrderId      IN      OR_order.order_id%TYPE
    )
    IS
        SELECT num_intentos, NUM_LECTSUGE
        FROM LDC_CTRLLECTURA
        WHERE ID_SOLICITUD = inuOrderId;
    
    --Registros
    rcOrderActivity    cuOrderActivity%ROWTYPE;

    -- Inserta o actualiza la orden en LDC_CTRLLECTURA
    PROCEDURE pRegistraConteo
    (
        inuPackageId      IN  mo_packages.package_id%TYPE,
        inumIntentos    IN  NUMBER,
        nuPeriCose 	    IN 	NUMBER,
        INUPRODUCTO 	IN 	NUMBER,
		inulectsuge  	IN 	NUMBER,
        inuFlagProcesado    IN ldc_ctrllectura.flag_procesado%TYPE
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        MERGE INTO LDC_CTRLLECTURA s1
        USING ( 
                SELECT  inuPackageId    id_solicitud,
                        inumIntentos    NUM_INT,
                        nuPeriCose      num_peri,
                        INUPRODUCTO     num_producto,
                        inulectsuge     NUM_LECTURA,
                        inuFlagProcesado flag_procesado
                FROM DUAL 
              ) s2 ON ( s1.id_solicitud = s2.id_solicitud)
        WHEN MATCHED THEN UPDATE SET s1.num_intentos = s2.NUM_INT,
                                     s1.NUM_PERICOSE =  s2.num_peri,
                                     s1.NUM_PRODUCTO = s2.num_producto,
									 s1.NUM_LECTSUGE  = S2.NUM_LECTURA,
                                     s1.flag_procesado  = S2.flag_procesado
        WHEN NOT MATCHED THEN INSERT (id_solicitud, num_intentos, NUM_PERICOSE, NUM_PRODUCTO, NUM_LECTSUGE, flag_procesado)
          values (s2.id_solicitud, s2.NUM_INT, s2.num_peri, s2.num_producto,  S2.NUM_LECTURA, S2.flag_procesado);

        COMMIT;

    EXCEPTION
        when Pkg_Error.CONTROLLED_ERROR then
            raise Pkg_Error.CONTROLLED_ERROR;
        when OTHERS then
            Pkg_Error.SetError;
            raise Pkg_Error.CONTROLLED_ERROR;
    END pRegistraConteo;    
BEGIN
    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
        
        nuOrderId   := or_bolegalizeorder.fnuGetCurrentOrder;
        nuCausalId  := pkg_bcordenes.fnuObtieneCausal(nuOrderId);
        nuTaskType  := pkg_bcordenes.fnuObtieneTipoTrabajo(nuOrderId);
        dtFechaEjec := pkg_bcordenes.fdtObtieneFechaEjecuFin(nuOrderId);

        -- Se valida si la causal es de exito
        IF pkg_bcordenes.fnuObtieneClaseCausal(nuCausalId) = 1 THEN

            IF cuOrderActivity%ISOPEN THEN
                CLOSE cuOrderActivity;
            END IF;

            OPEN cuOrderActivity(nuOrderId);
            FETCH cuOrderActivity INTO rcOrderActivity;
            CLOSE cuOrderActivity;

            IF cuLecturaAct%ISOPEN THEN
                CLOSE cuLecturaAct;
            END IF;
            -- Se obtiene la lectura de retiro
            OPEN cuLecturaAct(rcOrderActivity.product_id, rcOrderActivity.order_activity_id);
            FETCH cuLecturaAct INTO nuLectRetiro, nuperiactual , nuPeriConsact;
            CLOSE cuLecturaAct;

            IF cuUltimaLectura%ISOPEN THEN
                CLOSE cuUltimaLectura;
            END IF;
            -- Se obtiene la ?ltima lectura valida
            OPEN cuUltimaLectura(rcOrderActivity.product_id);
            FETCH cuUltimaLectura INTO nuUltiLect, dtFechaUltLect;
            CLOSE cuUltimaLectura;
            
            ut_trace.trace('--nuperiactual - nuPeriConsact - nuUltiLect -  dtFechaUltLect '||nuperiactual||' - '||nuPeriConsact||' - '||nuUltiLect||' - '||dtFechaUltLect,cnuLEVEL);
            
            nuCicloCons := pktblservsusc.fnugetsesucico(rcOrderActivity.product_id);

            IF cuObtienePerioAct%ISOPEN THEN
                CLOSE cuObtienePerioAct;
            END IF;

            OPEN cuObtienePerioAct(nuPeriConsact);
            FETCH cuObtienePerioAct INTO nuDiasConsActu, nuano, NUMES;
            CLOSE cuObtienePerioAct;
            
            ut_trace.trace('--nuDiasConsActu - nuano - NUMES'||nuDiasConsActu||' - '||nuano||' - '||nuMes,cnuLEVEL);
    
            nusolicitud := rcOrderActivity.package_id;
            IF nusolicitud IS NULL THEN
                Pkg_Error.setErrorMessage
                (
                    cnuGenericError,
                    'La orden no esta asociada a una solicitud'
                );
            END IF;
            
            IF cuExisteRegistro%ISOPEN THEN
                CLOSE cuExisteRegistro;
            END IF;
            OPEN cuExisteRegistro(nusolicitud);
            FETCH cuExisteRegistro INTO nuNumIntentos, nuLectSugGua;
            CLOSE cuExisteRegistro;	
            
            ut_trace.trace('--nuUltiLect: '||nuUltiLect,10);
            ut_trace.trace('--nuLectRetiro: '||nuLectRetiro,10);
            -- Se valida si la lectura de retiro es menor
            IF (nuLectRetiro <= nuUltiLect) THEN               
                ut_trace.trace('--nuNumIntentos: '||nuNumIntentos,10);
                
                -- si no esta regsitrada en LDC_CTRLLECTURA
                IF NVL(nuNumIntentos,0) = 0 THEN
                    nuNumIntentos := NVL(nuNumIntentos,0) + 1;
                    -- Se registra el itento
                    pRegistraConteo
                    (
                        nusolicitud,
                        nuNumIntentos,
                        nuPeriConsact,
                        rcOrderActivity.product_id,
                        null, 
                        'L'
                    );

                    Pkg_Error.setErrorMessage
                    (
                        cnuGenericError,
                        'Lectura de retiro menor o igual a la Ultima lectura de facturación. Por favor valide la información ingresada'
                    );

                -- Si ya esta registrada en LDC_CTRLLECTURA
                ELSIF (NVL(nuNumIntentos,0) > 0 AND nuNumIntentos = 1) THEN
                    -- Se obtiene la lectura sugerida
                    nuLectSuge := fnu_lecturasugerida
                                    (
                                        rcOrderActivity.product_id, 
                                        dtFechaEjec, 'E',
                                        dtFechaUltLect,
                                        nuperiactual,
                                        nuano,
                                        numes,
                                        nuUltiLect,
                                        nuPeriConsact,
                                        nuDiasConsActu,
                                        nuCicloCons
                                    );
                    
                    ut_trace.trace('LDC_PRLECTURAVALIDA - nuLectSuge: '||nuLectSuge,cnuLEVEL);

                    nuNumIntentos := NVL(nuNumIntentos,0) + 1;
                    -- Se registra el itento
                    
                    pRegistraConteo
                    (
                        nusolicitud,
                        nuNumIntentos,
                        nuPeriConsact,
                        rcOrderActivity.product_id,
                        nuLectSuge,
                        'L'
                    );

                    IF nuLectSuge <> nuLectRetiro THEN
                        Pkg_Error.setErrorMessage
                        (
                            cnuGenericError,
                            'La lectura ingresada no es correcta. La lectura de retiro a ingresar debe ser igual a '||nuLectSuge||'. Por favor validar.'
                        );
                    END IF;
                ELSIF (NVL(nuNumIntentos,0) > 0 AND nuNumIntentos = 2) THEN
                        nuNumIntentos := NVL(nuNumIntentos,0) + 1;

                        pRegistraConteo
                        (
                            nusolicitud,
                            nuNumIntentos,
                            nuPeriConsact,
                            rcOrderActivity.product_id,
                            nuLectSugGua,
                            'L'
                        );
                END IF;
            ELSE 
                IF (nuLectSugGua IS NULL) THEN
                    DELETE FROM LDC_CTRLLECTURA 
                    WHERE ID_SOLICITUD = nusolicitud;
                ELSE
                    nuNumIntentos := NVL(nuNumIntentos,0) + 1;

                     pRegistraConteo
                    (
                        nusolicitud,
                        nuNumIntentos,
                        nuPeriConsact,
                        rcOrderActivity.product_id,
                        nuLectSugGua,
                        'L'
                    );
                END IF;
            END IF;
        END IF;        
    ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);
EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERC||sbMethodName,cnuLEVELPUSHPOP);
        RAISE Pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERR||sbMethodName,cnuLEVELPUSHPOP);
        Pkg_Error.SetError;
        RAISE Pkg_Error.CONTROLLED_ERROR;
END LDC_PRLECTURAVAL;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRLECTURAVAL', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEINNOVA sobre LDC_PRLECTURAVAL
GRANT EXECUTE ON ADM_PERSON.LDC_PRLECTURAVAL TO REXEINNOVA;
/
