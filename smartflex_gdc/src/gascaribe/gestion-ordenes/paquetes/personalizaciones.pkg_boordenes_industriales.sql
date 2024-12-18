CREATE OR REPLACE PACKAGE personalizaciones.pkg_boordenes_industriales IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_boordenes_industriales
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   09/01/2024
    Descripcion :   Paquete con logica de negocio para manejo de ordenes de
                    industriales
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     15/05/2024      OSF-2561    Se modifica el procedimiento
                                                    prcReValorizacionAgrupadoras
    felipe.valencia     09/01/2024      OSF-1909    Creacion
*******************************************************************************/

    -- Retona el identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    PROCEDURE prcReValorizacionAgrupadoras;

    PROCEDURE prcProcesaValoresAgrupadora;

    PROCEDURE prcProcesaNoValorizada;

END pkg_boordenes_industriales;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boordenes_industriales IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-2561';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;

    
    csbPrograma 		CONSTANT VARCHAR2(100) 					 := 'LEORDJOB'||'_'||to_char(SYSDATE, 'DDMMYYHHMISS');

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 09/02/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/02/2024  OSF-1909 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcProcesaValoresAgrupadora 
    Descripcion     : Procesa ordenes a las cuales se les modificara el valor 
                      de los items
    Fecha           : 09/02/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/02/2024  OSF-1909 Creacion
    ***************************************************************************/
    PROCEDURE prcProcesaValoresAgrupadora
    IS 
        -------------------------------------------------------------------------
        --                             CONSTANTES                              --
        -------------------------------------------------------------------------
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcProcesaValoresAgrupadora';

        -------------------------------------------------------------------------
        --                            VARIABLES                                --
        -------------------------------------------------------------------------
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        rcItemsAgrupadora pkg_bcordenes_industriales.cuValorItemsAgrupadora%ROWTYPE;
    BEGIN 
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        FOR rcItemsAgrupadora IN pkg_bcordenes_industriales.cuValorItemsAgrupadora LOOP

            BEGIN
                pkg_or_order_items.prc_actual_item_orden
                (   
                    rcItemsAgrupadora.orden_agrupadora,
                    rcItemsAgrupadora.items_id,
                    1,
                    rcItemsAgrupadora.legal_item_amount,
                    rcItemsAgrupadora.value,
                    0,
                    NULL,
                    rcItemsAgrupadora.order_activity_id
                );

                pkg_detalle_ot_agrupada.prcActualizaordenagrupadora(rcItemsAgrupadora.orden_agrupadora, 'P');

           EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror, sberror  );
                    pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
                    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                    pkg_detalle_ot_agrupada.prcActualizaordenagrupadora(rcItemsAgrupadora.orden_agrupadora, 'E');
            END;

            COMMIT;
        END LOOP;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcProcesaValoresAgrupadora;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcProcesaNoValorizada 
    Descripcion     : Procesa ordenes no revalorizadas por no cumplimiento de 
                      condiciones
    Fecha           : 09/02/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     09/02/2024  OSF-1909 Creacion
    ***************************************************************************/
    PROCEDURE prcProcesaNoValorizada
    IS 
        -------------------------------------------------------------------------
        --                             CONSTANTES                              --
        -------------------------------------------------------------------------
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcProcesaNoValorizada';

        -------------------------------------------------------------------------
        --                            VARIABLES                                --
        -------------------------------------------------------------------------
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        rcNovalorizadas pkg_bcordenes_industriales.cuNoValorizada%ROWTYPE;
    BEGIN 
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        FOR rcNovalorizadas IN pkg_bcordenes_industriales.cuNoValorizada LOOP

            BEGIN

                pkg_detalle_ot_agrupada.prcActualizaordenagrupadora(rcNovalorizadas.orden_agrupadora, 'N');

           EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror, sberror  );
                    pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
                    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                    pkg_detalle_ot_agrupada.prcActualizaordenagrupadora(rcNovalorizadas.orden_agrupadora, 'E');
            END;

            COMMIT;
        END LOOP;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcProcesaNoValorizada;
    
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcReValorizacionAgrupadoras
        Descripcion     : 
        Autor           : 
        Fecha           : 28/12/2023
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     19/04/2024          OSF-2561: Se modifica para realizar
                                                el procesamiento por contrato
        felipe.valencia     28/12/2023          OSF-1909: Creación
    ***************************************************************************/
    PROCEDURE prcReValorizacionAgrupadoras
    IS 
        -------------------------------------------------------------------------
        --                             CONSTANTES                              --
        -------------------------------------------------------------------------
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcReValorizacionAgrupadoras';

        -------------------------------------------------------------------------
        --                            VARIABLES                                --
        -------------------------------------------------------------------------
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        nuTotalRegis        NUMBER;
        nuConteoRegistros 	NUMBER;
        nuOrdenesOK 		NUMBER;
        nuOrdenesError		NUMBER;

        blEsValorizable     BOOLEAN;

        rcOrdenAgrupadora 	pkg_bcordenes_industriales.cuOrdenesProceso%ROWTYPE;

        tbContratos         pkg_bcordenes_industriales.tytbCodigoContrato;
    BEGIN 
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuTotalRegis := 0;
        nuConteoRegistros 	:= 0;
        nuOrdenesOK 	:= 0;
        nuOrdenesError  := 0;

        tbContratos := pkg_bcordenes_industriales.ftbobtienecontratos;

        nuTotalRegis := tbContratos.COUNT;

        pkg_traza.trace('Total de Registros a procesar: ['||nuTotalRegis||']', pkg_traza.cnuNivelTrzDef);

        pkg_estaproc.prInsertaEstaproc(csbPrograma,nuTotalRegis);

        IF (pkg_bcordenes_industriales.cuOrdenesProceso%ISOPEN) THEN
            CLOSE pkg_bcordenes_industriales.cuOrdenesProceso;
        END IF;

        IF (nuTotalRegis > 0) THEN
            FOR i IN tbContratos.FIRST..tbContratos.LAST LOOP
                pkg_traza.trace('Contrato: ['||tbContratos(i)||']', pkg_traza.cnuNivelTrzDef);
                nuConteoRegistros := nuConteoRegistros + 1;
                FOR rcOrdenAgrupadora IN pkg_bcordenes_industriales.cuOrdenesProceso(tbContratos(i)) LOOP
                    

                    pkg_traza.trace('rcOrdenAgrupadora.task_type_id: '  			|| rcOrdenAgrupadora.task_type_id 			|| chr(10) ||
                                'rcOrdenAgrupadora.legalization_date: ' 	|| rcOrdenAgrupadora.legalization_date 	|| chr(10) ||
                                'rcOrdenAgrupadora.operating_unit_id: ' 	|| rcOrdenAgrupadora.operating_unit_id 	|| chr(10) ||
                                'rcOrdenAgrupadora.DEFINED_CONTRACT_ID: ' 	|| rcOrdenAgrupadora.DEFINED_CONTRACT_ID 	|| chr(10) ||
                                'rcOrdenAgrupadora.GEOGRAP_LOCATION_ID: ' 	|| rcOrdenAgrupadora.GEOGRAP_LOCATION_ID, 4);

                    BEGIN
                        pkg_detalle_ot_agrupada.prcProcesaOrdenesIndividuales
                        (
                            rcOrdenAgrupadora.order_id,
                            rcOrdenAgrupadora.legalization_date,
                            rcOrdenAgrupadora.operating_unit_id,
                            rcOrdenAgrupadora.defined_contract_id,
                            rcOrdenAgrupadora.geograp_location_id,
                            rcOrdenAgrupadora.task_type_id,
                            rcOrdenAgrupadora.activity_id
                        );

                        nuOrdenesOK := nuOrdenesOK + 1;

                        COMMIT;
                    EXCEPTION
                        WHEN OTHERS THEN
                            pkg_error.seterror;
                            pkg_error.geterror(nuerror, sberror  );
                            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
                            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
                            nuOrdenesError := nuOrdenesError + 1;
                            ROLLBACK;
                    END;
                END LOOP;

                pkg_estaproc.prActualizaAvance
                (
                    csbPrograma,
                    'Procesando: '||nuConteoRegistros,
                    nuConteoRegistros,
                    nuTotalRegis
                );
                COMMIT;

            END LOOP;

            pkg_estaproc.prActualizaAvance
            (
                csbPrograma,
                'Ejecutando revalorización de la orden ....',
                nuConteoRegistros,
                nuTotalRegis
            );

            prcProcesaValoresAgrupadora;

            prcProcesaNoValorizada;
        END IF;

        pkg_estaproc.practualizaestaproc
        (
            csbPrograma,
            'OK',
            'Proceso termino. Ordenes procesadas con exito: '||nuOrdenesOK||'.  Ordenes con Error: '||nuOrdenesError||'.'
        );
        COMMIT;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError( nuerror,sberror);
            pkg_estaproc.practualizaestaproc( csbPrograma, 'Error ', nuerror||'-'||sberror  );
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror  );
            pkg_estaproc.practualizaestaproc( csbPrograma, 'Error ', nuerror||'-'||sberror   );  
    END prcReValorizacionAgrupadoras;
END pkg_boordenes_industriales;
/
PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_boordenes_industriales
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_boordenes_industriales'), 'PERSONALIZACIONES');
END;
/
