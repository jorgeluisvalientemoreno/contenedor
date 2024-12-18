CREATE OR REPLACE PACKAGE LDC_ARCHTIPO_LISTA
IS

/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    Paquete     : LDC_ARCHTIPO_LISTA
    Autor       :   
    Fecha       :   
    Descripcion :   
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07-03-2024  OSF-2377    Se cambia el manejo de archivos a
                                        pkg_gestionArchivos
    jpinedc     14-03-2024  OSF-2377    Ajustes Validación Técnica
    jpinedc     29-05-2024  OSF-2377    Ajustes Validación Técnica2
*******************************************************************************/

    FUNCTION fnuObtieneListaActual (nuLocalidad NUMBER)
        RETURN NUMBER;

    FUNCTION fsbValidaTipoLista (nuTipoLista NUMBER)
        RETURN VARCHAR2;

    FUNCTION fsbValidaCodigoItem (nuCodItem NUMBER)
        RETURN VARCHAR2;

    FUNCTION fsbDescripcionLista (inuLocalidad     NUMBER,
                                  inuTipoLista     NUMBER,
                                  isbDescripcion   VARCHAR2)
        RETURN VARCHAR2;

    PROCEDURE ProcesarLineaArchCrea (inuLinea         NUMBER,
                                     isbLinea         VARCHAR2,
                                     ifArchivoError   IN OUT pkg_gestionArchivos.styArchivo,
                                     idtFechaIni      DATE,
                                     idtFechaFin      DATE,
                                     isbDescripcion   VARCHAR2,
                                     isbObservacion   VARCHAR2);

    PROCEDURE CargueArchivoCreaLista (sbDirectorio    VARCHAR2,
                                      sbArchivo       VARCHAR2,
                                      dtFechaIni      DATE,
                                      dtFechaFin      DATE,
                                      sbDescripcion   VARCHAR2,
                                      sbObservacion   VARCHAR2);

    PROCEDURE ProcesarLineaArchActu (inuLinea         NUMBER,
                                     isbLinea         VARCHAR2,
                                     ifArchivoError   IN OUT pkg_gestionArchivos.styArchivo,
                                     isbObservacion   VARCHAR2);

    PROCEDURE CargueArchivoActuLista (sbDirectorio    VARCHAR2,
                                      sbArchivo       VARCHAR2,
                                      sbObservacion   VARCHAR2);

    FUNCTION fblExisteLocalidad (
        inuLocalidad   LDC_LOC_TIPO_LIST_DEP.Localidad%TYPE)
        RETURN BOOLEAN;

    FUNCTION fnuListaPrecioAfin (inuTipo         NUMBER,
                                 inuTipListDes   NUMBER,
                                 inuLocalidad    NUMBER)
        RETURN NUMBER;

    PROCEDURE AsociarLocalidadLista (inuLocalidad     NUMBER,
                                     inuTipListDes    NUMBER,
                                     isbDescripcion   VARCHAR2);

    PROCEDURE CambiaTipoListaLocalidad (inuLocalidad     NUMBER,
                                        inuTipListDes    NUMBER,
                                        isbDescripcion   VARCHAR2);
                                        
    PROCEDURE OperacionesLocaTipLista;
END LDC_ARCHTIPO_LISTA;
/

CREATE OR REPLACE PACKAGE BODY LDC_ARCHTIPO_LISTA
IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    csbFILE_SEPARATOR     CONSTANT VARCHAR2 (1) := '/';
    csbSEPARADOR_CAMPOS   CONSTANT VARCHAR2 (1) := '|';
    cnuCAMPOS_MIN         CONSTANT NUMBER := 4;
    cnuFORMATO_INVALIDO   CONSTANT ge_message.message_id%TYPE := 112804;
    cnuTipoLista          CONSTANT NUMBER := 1;
    cnuCodItem            CONSTANT NUMBER := 2;
    cnuCosto              CONSTANT NUMBER := 3;
    cnuPrecio             CONSTANT NUMBER := 4;
    
    csbMODO_LECTURA       CONSTANT VARCHAR2(1) := pkg_gestionArchivos.csbMODO_LECTURA;
    csbMODO_ESCRITURA     CONSTANT VARCHAR2(1) := pkg_gestionArchivos.csbMODO_ESCRITURA;

    FUNCTION fnuObtieneListaActual (nuLocalidad NUMBER)
        RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtieneListaActual';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
        nuLista   NUMBER;

        CURSOR cuLista
        IS
        SELECT a.consecutivo     id
        FROM LDC_TIPO_LIST_DEPART a, LDC_LOC_TIPO_LIST_DEP b
        WHERE a.consecutivo = b.tipo_lista AND localidad = nuLocalidad;
         
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
      
        OPEN cuLista;
        FETCH cuLista INTO nuLista;
        CLOSE cuLista;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        RETURN NVL(nuLista,0);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);                    
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 0;
        WHEN OTHERS THEN          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);            
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 0;
    END fnuObtieneListaActual;

    FUNCTION fsbValidaTipoLista (nuTipoLista NUMBER)
        RETURN VARCHAR2
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbValidaTipoLista';    
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        sbExiste   VARCHAR2 (1);

        CURSOR cuValidaTipoLista
        IS
        SELECT 'Y'
        FROM LDC_TIPO_LIST_DEPART
        WHERE consecutivo = nuTipoLista;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        OPEN cuValidaTipoLista;
        FETCH cuValidaTipoLista INTO sbExiste;
        CLOSE cuValidaTipoLista;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        RETURN NVL(sbExiste,'N');
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);                    
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
        WHEN OTHERS THEN          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);            
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
    END fsbValidaTipoLista;


    FUNCTION fsbValidaCodigoItem (nuCodItem NUMBER)
        RETURN VARCHAR2
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbValidaTipoLista';    
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        sbExiste   VARCHAR2 (1);

        CURSOR cuValidaCodigoItem
        IS
        SELECT 'Y'
        FROM ge_items
        WHERE items_id = nuCodItem;
         
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        OPEN cuValidaCodigoItem;
        FETCH cuValidaCodigoItem INTO sbExiste;
        CLOSE cuValidaCodigoItem;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
            
        RETURN NVL(sbExiste,'N');
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);                    
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
        WHEN OTHERS THEN          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);            
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
    END fsbValidaCodigoItem;


    FUNCTION fblExisteLocalidad (
        inuLocalidad   LDC_LOC_TIPO_LIST_DEP.Localidad%TYPE)
        RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExisteLocalidad';    
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
        nuExiste   NUMBER;

        CURSOR cuExisteLocalidad
        IS
        SELECT 1
        FROM LDC_LOC_TIPO_LIST_DEP
        WHERE localidad = inuLocalidad;
        
        blExisteLocalidad BOOLEAN := FALSE;
                
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        OPEN cuExisteLocalidad;
        FETCH cuExisteLocalidad INTO nuExiste;
        CLOSE cuExisteLocalidad;

        IF nuExiste = 1 THEN
            blExisteLocalidad := TRUE;            
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

        RETURN (blExisteLocalidad);
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
    END fblExisteLocalidad;


    FUNCTION fnuListaPrecioAfin (inuTipo         NUMBER,
                                 inuTipListDes   NUMBER,
                                 inuLocalidad    NUMBER)
        RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuListaPrecioAfin';    
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuList_unitary_cost_id   NUMBER;
        nuLoca                   NUMBER;
        sbSql                    VARCHAR2 (1000);
        cuAsociaCambia           constants_per.tyRefCursor;
        
    
        CURSOR cuGE_LIST_UNITARY_COST
        IS
        SELECT g.list_unitary_cost_id
        FROM GE_LIST_UNITARY_COST g
        WHERE geograp_location_id = nuLoca
        ORDER BY g.validity_final_date DESC,
        g.list_unitary_cost_id DESC;
                                         
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
            
        -- Se busca una localidad que se encuentre asociada al tipo de lista escogida
        IF (inuTipo = 1)
        THEN
            sbSql := 'select l.localidad
                from LDC_LOC_TIPO_LIST_DEP l
               where tipo_lista = ' || inuTipListDes || '
                 and localidad <> ' || inuLocalidad;
        ELSE
            sbSql := 'select l.localidad
                from LDC_LOC_TIPO_LIST_DEP l
               where tipo_lista = ' || inuTipListDes;
        END IF;


        OPEN cuAsociaCambia FOR sbSql;
        FETCH cuAsociaCambia INTO nuLoca;
        CLOSE cuAsociaCambia;

        IF nuLoca IS NOT NULL THEN

            OPEN cuGE_LIST_UNITARY_COST;
            FETCH cuGE_LIST_UNITARY_COST INTO nuList_unitary_cost_id;
            CLOSE cuGE_LIST_UNITARY_COST;
                        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

        RETURN nuList_unitary_cost_id;
                        
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
    END fnuListaPrecioAfin;

    FUNCTION fsbDescripcionLista (inuLocalidad     NUMBER,
                                  inuTipoLista     NUMBER,
                                  isbDescripcion   VARCHAR2)
        RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbDescripcionLista';    
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        sbDesListaCosto   VARCHAR2 (200);

        CURSOR cuDesListaCosto
        IS
        SELECT SUBSTR (   l.descripcion
                       || ' - '
                       || (SELECT description
                             FROM ge_geogra_location g
                            WHERE g.geograp_location_id = l.departamento)
                       || ' - '
                       || (SELECT description
                             FROM ge_geogra_location g
                            WHERE g.geograp_location_id = inuLocalidad)
                       || ' - '
                       || isbDescripcion,
                       1,
                       200)
          FROM LDC_TIPO_LIST_DEPART l
         WHERE consecutivo = inuTipoLista;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        OPEN cuDesListaCosto;
        FETCH cuDesListaCosto INTO sbDesListaCosto;
        CLOSE cuDesListaCosto;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
        RETURN sbDesListaCosto;
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
    END fsbDescripcionLista;

    PROCEDURE ProcesarLineaArchCrea (inuLinea         NUMBER,
                                     isbLinea         VARCHAR2,
                                     ifArchivoError   IN OUT pkg_gestionArchivos.styArchivo,
                                     idtFechaIni      DATE,
                                     idtFechaFin      DATE,
                                     isbDescripcion   VARCHAR2,
                                     isbObservacion   VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ProcesarLineaArchCrea';    
            
        sbUSUARIO                VARCHAR2 (40);
        sbTERMINAL               VARCHAR2 (60);

        nuTipoLista              LDC_TIPO_LIST_DEPART.consecutivo%TYPE;
        nuCodItem                ge_items.items_id%TYPE;
        nuCosto                  NUMBER;
        nuPrecio                 NUMBER;
        -- Tabla con los campos de la linea
        tbDatosLinea             UT_String.TyTb_String;
        nuError                  NUMBER;
        sbError                  VARCHAR2 (4000) := '.';

        nuList_unitary_cost_id   GE_LIST_UNITARY_COST.list_unitary_cost_id%TYPE;
        RCDATCOS                 DAGE_UNIT_COST_ITE_LIS.STYGE_UNIT_COST_ITE_LIS;
        RCDATLIS                 DAGE_LIST_UNITARY_COST.STYGE_LIST_UNITARY_COST;
        sbDesListaCosto          GE_LIST_UNITARY_COST.DESCRIPTION%TYPE;
        nuNuevaLista             GE_LIST_UNITARY_COST.list_unitary_cost_id%TYPE;
        nuCostoAnt               NUMBER (30, 2);
        nuPrecioAnt              NUMBER (30, 2);
        sbForma                  VARCHAR2 (20) := 'LDCCRELISCOS';
        sbComentarios            LDC_ITEMS_AUDIT.COMMENTS%TYPE;
        sbactivaredondear        ld_parameter.value_chain%TYPE;
        sbcosto                  VARCHAR2 (40);
        sbprecio                 VARCHAR2 (40);
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
         
        sbactivaredondear :=
            dald_parameter.fsbGetValue_Chain ('LD_REDONDEAR_VALOR', NULL);

        --Crea SavePoint
        SAVEPOINT AgregarObservSP;

        sbUSUARIO := USER;
        sbTERMINAL := USERENV ('TERMINAL');


        --Extrae los campos de la linea en una tabla PL:
        UT_String.ExtString (isbLinea, csbSEPARADOR_CAMPOS, tbDatosLinea);

        --Valida la cantidad de parametros obtenida
        IF tbDatosLinea.COUNT < cnuCAMPOS_MIN
        THEN
            pkg_error.setErrorMessage (cnuFORMATO_INVALIDO, inuLinea);
        END IF;

        --Obtiene el id de la Orden, el tipo Observacion y la Observacion
        nuTipoLista := tbDatosLinea (cnuTipoLista);
        nuCodItem := tbDatosLinea (cnuCodItem);
        sbcosto := tbDatosLinea (cnuCosto);
        sbPrecio :=
            REPLACE (REPLACE (tbDatosLinea (cnuPrecio), CHR (10)), CHR (13));
        nuCosto := ROUND (TO_NUMBER (TRIM (sbcosto)), 2);
        nuPrecio := ROUND (TO_NUMBER (TRIM (sbprecio)), 2);

        -- Validamos si se redondea el valor
        IF sbactivaredondear = 'S'
        THEN
            nuCosto := ROUND (nuCosto, 0);
            nuPrecio := ROUND (nuPrecio, 0);
        END IF;

        --Valida que el tipo de lista exista -- sea valido
        IF (LDC_ARCHTIPO_LISTA.fsbValidaTipoLista (nuTipoLista) =
            constants_per.csbNO)
        THEN
            sbError :=
                   sbError
                || 'Tipo de Lista ('
                || nuTipoLista
                || ') no existe. ';
        END IF;

        --Valida que el c?digo del item exista -- sea valido
        IF (LDC_ARCHTIPO_LISTA.fsbValidaCodigoItem (nuCodItem) =
            constants_per.csbNO)
        THEN
            sbError :=
                sbError || 'Codigo de item (' || nuCodItem || ') no existe. ';
        END IF;

        --Valida que el costo y el precio sean validos --> mayor a cero
        IF (nuCosto < 0)
        THEN
            sbError := sbError || 'Costo (' || nuCosto || ') no v?lido. ';
        END IF;


        IF (nuPrecio < 0)
        THEN
            sbError := sbError || 'Precio (' || nuPrecio || ') no v?lido. ';
        END IF;


        IF (sbError <> '.')
        THEN
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                ifArchivoError,
                   '['
                || LPAD (inuLinea, 6, ' ')
                || ']['
                || nuCodItem
                || ']['
                || sbError
                || ']'
                || CHR (13));
        ELSE
            -- campos correctos
            /*
            Por cada l?nea del archivo que pase las validaciones, se debe obtener el tipo de lista,
            y consultar en la tabla LDC_LOC_TIPO_LIST_DEP, las localidades que est?n asociadas a ese tipo de lista.
            Luego por cada localidad se busca la lista de costos que tengan como rango de fechas de vigencia,
            las fechas que se ingresan por pantalla. (GE_LIST_UNITARY_COST):*/


            FOR lis IN (SELECT localidad
                          FROM LDC_LOC_TIPO_LIST_DEP
                         WHERE tipo_lista = nuTipoLista /*and localidad = 13*/
                                                       )
            LOOP
                BEGIN
                    -- se busca si exite lista con las vigencias ingresadas para la localidad
                    SELECT g.list_unitary_cost_id
                      INTO nuList_unitary_cost_id
                      FROM GE_LIST_UNITARY_COST g
                     WHERE     geograp_location_id = lis.localidad
                           AND TRUNC (g.validity_start_date) =
                               TRUNC (idtFechaIni)
                           AND TRUNC (g.validity_final_date) =
                               TRUNC (idtFechaFin);

                    /*   Si se encuentra, se busca si el ?tem definido en la l?nea del archivo,
                       actualmente ya existe en esa lista de costo (GE_UNIT_COST_ITE_LIS), en caso que exista,
                       se le actualizan los valores (costo y precio) de lo contrario, se inserta el nuevo ?tem.
                       El campo observaci?n debe quedar registrado en la tabla de auditor?a explicada en el ?ltimo punto.*/
                    IF (DAGE_UNIT_COST_ITE_LIS.FBLEXIST (
                            nuCodItem,
                            nuList_unitary_cost_id))
                    THEN
                        -- se obtienen datos previos
                        nuCostoAnt :=
                            DAGE_UNIT_COST_ITE_LIS.FNUGETPRICE (
                                nuCodItem,
                                nuList_unitary_cost_id,
                                1);
                        nuPrecioAnt :=
                            DAGE_UNIT_COST_ITE_LIS.FNUGETSALES_VALUE (
                                nuCodItem,
                                nuList_unitary_cost_id,
                                1);


                        UPDATE GE_UNIT_COST_ITE_LIS
                           SET price = nuCosto, sales_value = nuPrecio
                         WHERE     items_id = nuCodItem
                               AND list_unitary_cost_id =
                                   nuList_unitary_cost_id;


                        -- se valida si hay observaci?n, sino se envia nombre de FORMA
                        IF (isbObservacion IS NULL)
                        THEN
                            sbComentarios := sbForma;
                        ELSE
                            sbComentarios := isbObservacion;
                        END IF;

                        PKG_LDC_ITEMS_AUDIT.PRINSERTAR (
                            nuList_unitary_cost_id,
                            nuCodItem,
                            nuCostoAnt,
                            nuCosto,
                            nuPrecioAnt,
                            nuPrecio,
                            sbComentarios,
                            'A');
                    ELSE
                        -- no existe, se crea el item
                        RCDATCOS.items_id := nuCodItem;
                        RCDATCOS.list_unitary_cost_id :=
                            nuList_unitary_cost_id;
                        RCDATCOS.price := nuCosto;
                        RCDATCOS.last_update_date := SYSDATE;
                        RCDATCOS.user_id := sbUSUARIO;
                        RCDATCOS.terminal := sbTERMINAL;
                        RCDATCOS.sales_value := nuPrecio;
                        DAGE_UNIT_COST_ITE_LIS.INSRECORD (RCDATCOS);
                    END IF;
                EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                        /*        Si no se encuentra se le crea una nueva lista de costo, donde la descripci?n de esta conserve
                                  la nomenclatura ( descripci?n del tipo de lista al que se va a asociar la localidad ?
                                                    descripci?n de la localidad ?
                                                    descripci?n del departamento ?
                                                    campo descripci?n digitada en el PB),
                                  e inmediatamente se actualiza las fechas de la lista vigente,
                                  para que la fecha final quede igual a la fecha inicial ingresada en pantalla, menos un d?a.
                                  Y para la nueva lista, la fecha de vigencia ser?n las fechas ingresadas por pantalla.
                                  A esta nueva lista se le inserta el ?tem que contenga la l?nea del archivo.*/


                        -- se busca si exite alguna vigencia para la localidad
                        BEGIN
                            SELECT *
                              INTO nuList_unitary_cost_id
                              FROM (  SELECT g.list_unitary_cost_id
                                        FROM GE_LIST_UNITARY_COST g
                                       WHERE geograp_location_id =
                                             lis.localidad
                                    ORDER BY g.validity_final_date DESC,
                                             g.list_unitary_cost_id DESC)
                             WHERE ROWNUM = 1;



                            UPDATE GE_LIST_UNITARY_COST
                               SET validity_final_date =
                                       TRUNC (idtFechaIni) - 1
                             WHERE list_unitary_cost_id =
                                   nuList_unitary_cost_id;
                        EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                                sbError :=
                                       'No hay en lista de costos vigencias para la localidad ('
                                    || lis.localidad
                                    || ')';
                        END;

                        sbDesListaCosto :=
                            fsbDescripcionLista (lis.localidad,
                                                 nuTipoLista,
                                                 isbDescripcion);

                        -- Se crea la nueva lista y se arma la descripci?n
                        nuNuevaLista := SEQ_GE_LIST_UNITARY_COST.NEXTVAL;

                        RCDATLIS.List_Unitary_Cost_Id := nuNuevaLista;
                        RCDATLIS.Description := sbDesListaCosto;
                        RCDATLIS.Validity_Start_Date := idtFechaIni;
                        RCDATLIS.Validity_Final_Date := idtFechaFin;
                        RCDATLIS.User_Id := sbUSUARIO;
                        RCDATLIS.Terminal := sbTERMINAL;
                        RCDATLIS.Geograp_Location_Id := lis.localidad;


                        DAGE_LIST_UNITARY_COST.INSRECORD (RCDATLIS);


                        -- Se adiciona el item
                        RCDATCOS.items_id := nuCodItem;
                        RCDATCOS.list_unitary_cost_id := nuNuevaLista;
                        RCDATCOS.price := nuCosto;
                        RCDATCOS.last_update_date := SYSDATE;
                        RCDATCOS.user_id := sbUSUARIO;
                        RCDATCOS.terminal := sbTERMINAL;
                        RCDATCOS.sales_value := nuPrecio;


                        DAGE_UNIT_COST_ITE_LIS.INSRECORD (RCDATCOS);
                END;
            END LOOP;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            ROLLBACK TO AgregarObservSP;
            pkg_Error.getError (nuError, sbError);
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                ifArchivoError,
                   '['
                || LPAD (inuLinea, 6, ' ')
                || ']['
                || nuError
                || '-'
                || sbError
                || ']'
                || CHR (13));

            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            ROLLBACK TO AgregarObservSP;
            pkg_Error.getError (nuError, sbError);
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                ifArchivoError,
                   '['
                || LPAD (inuLinea, 6, ' ')
                || ']['
                || nuError
                || '-'
                || sbError
                || ']'
                || CHR (13));
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END ProcesarLineaArchCrea;

    /*****************************************************************
    ******************************************************************/
    PROCEDURE CargueArchivoCreaLista (sbDirectorio    VARCHAR2,
                                      sbArchivo       VARCHAR2,
                                      dtFechaIni      DATE,
                                      dtFechaFin      DATE,
                                      sbDescripcion   VARCHAR2,
                                      sbObservacion   VARCHAR2)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CargueArchivoCreaLista';    
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
        
        fArchivDatos     pkg_gestionArchivos.styArchivo;
        fpError          pkg_gestionArchivos.styArchivo;

        sbArchivoError   VARCHAR2 (200);
        sbLinea          VARCHAR2 (32700);
        nuRegistro       NUMBER := 0;
        sbRuta           VARCHAR2 (200);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        -- Obtenemos los par?metros de la forma
   
        sbRuta := pkg_BCDirectorios.fsbGetRuta (sbDirectorio);

        IF (dtFechaFin < dtFechaIni)
        THEN
            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'Fecha Final no puede ser menor a la Fecha Inicial');
        END IF;


        -- Verifica si el archivo existe en la ruta especificada
        pkg_gestionArchivos.prcValidaExisteArchivo_SMF (
            sbRuta , sbArchivo);


        --Abre el archivo de Observaciones en modo lectura
        fArchivDatos := pkg_gestionArchivos.ftAbrirArchivo_SMF (
                                   sbRuta,
                                   sbArchivo,
                                   csbMODO_LECTURA);


        sbArchivoError :=
            ut_string.ExtStrField (sbArchivo, '.', 1) || '_inc.log';



        --Crea y abre el archivo para el log de errores
        fpError := pkg_gestionArchivos.ftAbrirArchivo_SMF (
                                   sbRuta,
                                   sbArchivoError,
                                   csbMODO_ESCRITURA);

        --Se procesa cada linea del archivo
        LOOP
            BEGIN
                sbLinea := pkg_gestionArchivos.fsbObtenerLinea_SMF (fArchivDatos);
                nuRegistro := nuRegistro + 1;
                pkg_Traza.Trace ('nuRegistro: ' || nuRegistro, 5);

                --Registra la observacion a la orden
                ProcesarLineaArchCrea (nuRegistro,
                                       sbLinea,
                                       fpError,
                                       dtFechaIni,
                                       dtFechaFin,
                                       sbDescripcion,
                                       sbObservacion);
                sbLinea := NULL;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        EXIT;
            END;
        END LOOP;

        --Se realiza persistencia
        COMMIT;

        --Cierra los archivos
        IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fArchivDatos)
        THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF (fArchivDatos);
        END IF;

        IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpError)
        THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF (fpError);
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fArchivDatos)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fArchivDatos);
            END IF;

            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpError)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fpError);
            END IF;
            pkg_Error.getError(nuError, sbError);
            pkg_Traza.Trace (
                   'Fin others LDC_ARCHTIPO_LISTA.CargueDesdeArchivo'
                || nuError,
                5);
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fArchivDatos)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fArchivDatos);
            END IF;

            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpError)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fpError);
            END IF;

            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_Traza.Trace (
                   'Fin others LDC_ARCHTIPO_LISTA.CargueDesdeArchivo'
                || nuError,
                5);
            RAISE pkg_Error.CONTROLLED_ERROR;
    END CargueArchivoCreaLista;



    PROCEDURE ProcesarLineaArchActu (inuLinea         NUMBER,
                                     isbLinea         VARCHAR2,
                                     ifArchivoError   IN OUT pkg_gestionArchivos.styArchivo,
                                     isbObservacion   VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ProcesarLineaArchActu';
       
        sbUSUARIO                VARCHAR2 (40);
        sbTERMINAL               VARCHAR2 (60);


        nuTipoLista              LDC_TIPO_LIST_DEPART.consecutivo%TYPE;
        nuCodItem                ge_items.items_id%TYPE;
        nuCosto                  NUMBER;
        nuPrecio                 NUMBER;


        -- Tabla con los campos de la linea
        tbDatosLinea             UT_String.TyTb_String;
        nuError                  NUMBER;
        sbError                  VARCHAR2 (4000) := '.';

        nuList_unitary_cost_id   GE_LIST_UNITARY_COST.list_unitary_cost_id%TYPE;
        RCDATCOS                 DAGE_UNIT_COST_ITE_LIS.STYGE_UNIT_COST_ITE_LIS;
        nuCostoAnt               NUMBER;
        nuPrecioAnt              NUMBER;
        sbForma                  VARCHAR2 (20) := 'LDCACTULISCOS';
        sbComentarios            LDC_ITEMS_AUDIT.COMMENTS%TYPE;
        sbactivaredondear        ld_parameter.value_chain%TYPE;
        sbcosto                  VARCHAR2 (40);
        sbprecio                 VARCHAR2 (40);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        sbactivaredondear :=
            dald_parameter.fsbGetValue_Chain ('LD_REDONDEAR_VALOR', NULL);
        --Crea SavePoint
        SAVEPOINT AgregarObservSP;

        sbUSUARIO := USER;
        sbTERMINAL := USERENV ('TERMINAL');


        --Extrae los campos de la linea en una tabla PL:
        UT_String.ExtString (isbLinea, csbSEPARADOR_CAMPOS, tbDatosLinea);

        --Valida la cantidad de parametros obtenida
        IF tbDatosLinea.COUNT < cnuCAMPOS_MIN
        THEN
            pkg_error.setErrorMessage (cnuFORMATO_INVALIDO, inuLinea);
        END IF;

        --Obtiene el id de la Orden, el tipo Observacion y la Observacion
        nuTipoLista := tbDatosLinea (cnuTipoLista);
        nuCodItem := tbDatosLinea (cnuCodItem);
        sbcosto := tbDatosLinea (cnuCosto);
        sbPrecio :=
            REPLACE (REPLACE (tbDatosLinea (cnuPrecio), CHR (10)), CHR (13));
        nuCosto := ROUND (TO_NUMBER (TRIM (sbcosto)), 2);
        nuPrecio := ROUND (TO_NUMBER (TRIM (sbprecio)), 2);

        -- Validamos si se redondea el valor
        IF sbactivaredondear = 'S'
        THEN
            nuCosto := ROUND (nuCosto, 0);
            nuPrecio := ROUND (nuPrecio, 0);
        END IF;

        --Valida que el tipo de lista exista -- sea valido
        IF (LDC_ARCHTIPO_LISTA.fsbValidaTipoLista (nuTipoLista) =
            constants_per.csbNO)
        THEN
            sbError :=
                   sbError
                || 'Tipo de Lista ('
                || nuTipoLista
                || ') no existe. ';
        END IF;

        --Valida que el c?digo del item exista -- sea valido
        IF (LDC_ARCHTIPO_LISTA.fsbValidaCodigoItem (nuCodItem) =
            constants_per.csbNO)
        THEN
            sbError :=
                sbError || 'Codigo de item (' || nuCodItem || ') no existe. ';
        END IF;

        --Valida que el costo y el precio sean validos --> mayor a cero
        IF (nuCosto < 0)
        THEN
            sbError := sbError || 'Costo (' || nuCosto || ') no v?lido. ';
        END IF;


        IF (nuPrecio < 0)
        THEN
            sbError := sbError || 'Precio (' || nuPrecio || ') no v?lido. ';
        END IF;


        IF (sbError <> '.')
        THEN
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                ifArchivoError,
                   '['
                || LPAD (inuLinea, 6, ' ')
                || ']['
                || nuCodItem
                || ']['
                || sbError
                || ']'
                || CHR (13));
        ELSE
            -- campos correctos
            /*
            Por cada l?nea del archivo que pase las validaciones, se debe obtener el tipo de lista, y consultar
            en la tabla LDC_LOC_TIPO_LIST_DEP, las localidades que est?n asociadas a ese tipo de lista.
            Luego por cada localidad se busca la lista de costo vigente, y se valida si el ?tem a actualizar
            existe en dicha lista de costos. En caso que exista se actualiza el costo y el precio de acuerdo a
            los valores de la l?nea, y en caso contrario se inserten (GE_LIST_UNITARY_COST).*/


            FOR lis IN (SELECT localidad
                          FROM LDC_LOC_TIPO_LIST_DEP
                         WHERE tipo_lista = nuTipoLista)
            LOOP
                BEGIN
                    SELECT *
                      INTO nuList_unitary_cost_id
                      FROM (  SELECT g.list_unitary_cost_id
                                FROM GE_LIST_UNITARY_COST g
                               WHERE geograp_location_id = lis.localidad
                            ORDER BY g.validity_final_date DESC,
                                     g.list_unitary_cost_id DESC)
                     WHERE ROWNUM = 1;


                    IF (DAGE_UNIT_COST_ITE_LIS.FBLEXIST (
                            nuCodItem,
                            nuList_unitary_cost_id))
                    THEN
                        -- se obtienen datos previos
                        nuCostoAnt :=
                            DAGE_UNIT_COST_ITE_LIS.FNUGETPRICE (
                                nuCodItem,
                                nuList_unitary_cost_id,
                                1);
                        nuPrecioAnt :=
                            DAGE_UNIT_COST_ITE_LIS.FNUGETSALES_VALUE (
                                nuCodItem,
                                nuList_unitary_cost_id,
                                1);


                        UPDATE GE_UNIT_COST_ITE_LIS
                           SET price = nuCosto, sales_value = nuPrecio
                         WHERE     items_id = nuCodItem
                               AND list_unitary_cost_id =
                                   nuList_unitary_cost_id;


                        -- se valida si hay observaci?n, sino se envia nombre de FORMA
                        IF (isbObservacion IS NULL)
                        THEN
                            sbComentarios := sbForma;
                        ELSE
                            sbComentarios := isbObservacion;
                        END IF;

                        PKG_LDC_ITEMS_AUDIT.PRINSERTAR (
                            nuList_unitary_cost_id,
                            nuCodItem,
                            nuCostoAnt,
                            nuCosto,
                            nuPrecioAnt,
                            nuPrecio,
                            sbComentarios,
                            'A');
                    ELSE
                        -- no existe, se crea el item
                        RCDATCOS.items_id := nuCodItem;
                        RCDATCOS.list_unitary_cost_id :=
                            nuList_unitary_cost_id;
                        RCDATCOS.price := nuCosto;
                        RCDATCOS.last_update_date := SYSDATE;
                        RCDATCOS.user_id := sbUSUARIO;
                        RCDATCOS.terminal := sbTERMINAL;
                        RCDATCOS.sales_value := nuPrecio;
                        DAGE_UNIT_COST_ITE_LIS.INSRECORD (RCDATCOS);
                    END IF;
                EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                        sbError :=
                               'No hay vigencias en lista de costos para la localidad ('
                            || lis.localidad
                            || ')';
                        pkg_gestionArchivos.prcEscribirLinea_SMF (
                            ifArchivoError,
                               '['
                            || LPAD (inuLinea, 6, ' ')
                            || ']['
                            || nuCodItem
                            || ']['
                            || sbError
                            || ']'
                            || CHR (13));
                END;
            END LOOP;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            ROLLBACK TO AgregarObservSP;
            pkg_Error.getError (nuError, sbError);
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                ifArchivoError,
                   '['
                || LPAD (inuLinea, 6, ' ')
                || ']['
                || nuError
                || '-'
                || sbError
                || ']'
                || CHR (13));

            pkg_Traza.Trace (
                'Fin CONTROLLED_ERROR LDC_ARCHTIPO_LISTA.ProcesarLineaArchivo',
                5);
        WHEN OTHERS
        THEN
            pkg_Error.setError;
            ROLLBACK TO AgregarObservSP;
            pkg_Error.getError (nuError, sbError);
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                ifArchivoError,
                   '['
                || LPAD (inuLinea, 6, ' ')
                || ']['
                || nuError
                || '-'
                || sbError
                || ']'
                || CHR (13));

            pkg_Traza.Trace (
                   'Fin others LDC_ARCHTIPO_LISTA.ProcesarLineaArchivo'
                || nuError,
                5);
    END ProcesarLineaArchActu;

    /*****************************************************************
    ******************************************************************/
    PROCEDURE CargueArchivoActuLista (sbDirectorio    VARCHAR2,
                                      sbArchivo       VARCHAR2,
                                      sbObservacion   VARCHAR2)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CargueArchivoActuLista';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    
        fArchivDatos     pkg_gestionArchivos.styArchivo;
        fpError          pkg_gestionArchivos.styArchivo;

        sbArchivoError   ge_boInstanceControl.stysbValue;
        sbLinea          VARCHAR2 (32700);
        nuRegistro       NUMBER := 0;
        sbRuta           VARCHAR2 (200);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        -- Obtenemos los par?metros de la forma
        sbRuta := pkg_BCDirectorios.fsbGetRuta (sbDirectorio);

        -- Verifica si el archivo existe en la ruta especificada
        pkg_gestionArchivos.prcValidaExisteArchivo_SMF (
            sbRuta , sbArchivo);

        --Abre el archivo de Observaciones en modo lectura
        fArchivDatos := pkg_gestionArchivos.ftAbrirArchivo_SMF (
                                   sbRuta,
                                   sbArchivo,
                                   csbMODO_LECTURA);

        -- Archivo de errores
        -- Se crea nombre de archivo con el mismo nombre del archivo de datos y extension .log
        sbArchivoError :=
            ut_string.ExtStrField (sbArchivo, '.', 1) || '_inc.log';

        --Crea y abre el archivo para el log de errores
        fpError := pkg_gestionArchivos.ftAbrirArchivo_SMF (
                                   sbRuta,
                                   sbArchivoError,
                                   csbMODO_ESCRITURA);

        --Se procesa cada linea del archivo
        LOOP
        
            BEGIN
            
                sbLinea := pkg_gestionArchivos.fsbObtenerLinea_SMF (fArchivDatos);

                nuRegistro := nuRegistro + 1;
                pkg_Traza.Trace ('nuRegistro: ' || nuRegistro, 5);

                --Registra la observacion a la orden
                ProcesarLineaArchActu (nuRegistro,
                                       sbLinea,
                                       fpError,
                                       sbObservacion);
                sbLinea := NULL;
                
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN 
                        EXIT;
            END;
        END LOOP;

        --Se realiza persistencia
        COMMIT;

        --Cierra los archivos
        IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fArchivDatos)
        THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF (fArchivDatos);
        END IF;

        IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpError)
        THEN
            pkg_gestionArchivos.prcCerrarArchivo_SMF (fpError);
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR
        THEN
            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fArchivDatos)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fArchivDatos);
            END IF;

            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpError)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fpError);
            END IF;

            pkg_Error.getError(nuError,sbError);
            
            pkg_Traza.Trace (
                'Fin CONTROLLED_ERROR LDC_ARCHTIPO_LISTA.CargueDesdeArchivo[' || sbError || ']',
                5);
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fArchivDatos)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fArchivDatos);
            END IF;

            IF pkg_gestionArchivos.fblArchivoAbierto_SMF (fpError)
            THEN
                pkg_gestionArchivos.prcCerrarArchivo_SMF (fpError);
            END IF;

            pkg_Error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_Traza.Trace (
                   'Fin others LDC_ARCHTIPO_LISTA.CargueDesdeArchivo['
                || sbError || ']',
                5);
            RAISE pkg_Error.CONTROLLED_ERROR;
    END CargueArchivoActuLista;


    PROCEDURE AsociarLocalidadLista (inuLocalidad     NUMBER,
                                     inuTipListDes    NUMBER,
                                     isbDescripcion   VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'AsociarLocalidadLista';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
        nuExiste                 NUMBER;
        nuDepartamento           ge_geogra_location.geo_loca_father_id%TYPE;
        nuList_unitary_cost_id   GE_LIST_UNITARY_COST.list_unitary_cost_id%TYPE;
        nuNuevaLista             NUMBER;
        sbUSUARIO                VARCHAR2 (40) := USER;
        sbTERMINAL               VARCHAR2 (60) := USERENV ('TERMINAL');
        sbDesListaCosto          VARCHAR2 (200);

        --Valida si ya existe una lista de costo con la fecha incial y final para una localidad
        CURSOR cuValidaLista (
            nuGeograpLocation   ge_geogra_location.geograp_location_id%TYPE,
            nuListaRef          ge_list_unitary_cost.list_unitary_cost_id%TYPE)
        IS
            SELECT COUNT (1)
              FROM ge_list_unitary_cost lc, ge_list_unitary_cost lref
             WHERE     lc.geograp_location_id = nuGeograpLocation
                   AND lref.list_unitary_cost_id = nuListaRef
                   AND lc.validity_start_date = lref.validity_start_date
                   AND lc.validity_final_date = lref.validity_final_date;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        -- Valida que la localidad no est? asociada a un tipo de lista
        IF (fblExisteLocalidad (inuLocalidad))
        THEN
            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'La localidad ya esta asociada a un tipo de lista. Cambie la opcion seleccionada.');
        END IF;

        /*Validar que el tipo de lista destino seleccionada,
        se encuentre configurada para el departamento al cual pertenece la localidad.*/
        SELECT geo_loca_father_id
          INTO nuDepartamento
          FROM ge_geogra_location
         WHERE geograp_location_id = inuLocalidad;


        BEGIN
            SELECT 1
              INTO nuExiste
              FROM LDC_TIPO_LIST_DEPART
             WHERE     consecutivo = inuTipListDes
                   AND departamento = nuDepartamento;
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                pkg_error.setErrorMessage (
                    isbMsgErrr =>
                       'No hay lista parametrizada para el departamento('
                    || nuDepartamento
                    || ') al que pertenece la localidad('
                    || inuLocalidad
                    || ')');
        END;


        -- Se busca una localidad que se encuentre asociada al tipo de lista y se arma descripci?n
        nuList_unitary_cost_id :=
            fnuListaPrecioAfin (1, inuTipListDes, inuLocalidad);


        IF (nuList_unitary_cost_id IS NOT NULL)
        THEN
            /*se realiza la asociaci?n de la nueva localidad al tipo de lista */
            INSERT INTO LDC_LOC_TIPO_LIST_DEP
                 VALUES (inuTipListDes, nuDepartamento, inuLocalidad);


            -- Se crea la nueva lista y se arma la descripci?n
            sbDesListaCosto :=
                fsbDescripcionLista (inuLocalidad,
                                     inuTipListDes,
                                     isbDescripcion);

            OPEN cuValidaLista (inuLocalidad, nuList_unitary_cost_id);

            FETCH cuValidaLista INTO nuExiste;

            CLOSE cuValidaLista;

            IF nuExiste = 0
            THEN
                SELECT SEQ_GE_LIST_UNITARY_COST.NEXTVAL
                  INTO nuNuevaLista
                  FROM DUAL;


                INSERT INTO GE_LIST_UNITARY_COST (list_unitary_cost_id,
                                                  description,
                                                  validity_start_date,
                                                  validity_final_date,
                                                  user_id,
                                                  terminal,
                                                  geograp_location_id)
                    SELECT nuNuevaLista,
                           sbDesListaCosto,
                           Validity_Start_Date,
                           Validity_Final_Date,
                           sbUSUARIO,
                           sbTERMINAL,
                           inuLocalidad
                      FROM GE_LIST_UNITARY_COST
                     WHERE List_Unitary_Cost_Id = nuList_unitary_cost_id;


                pkg_Traza.Trace (SQL%ROWCOUNT);


                -- Se adiciona el item
                INSERT INTO GE_UNIT_COST_ITE_LIS (items_id,
                                                  list_unitary_cost_id,
                                                  price,
                                                  last_update_date,
                                                  user_id,
                                                  terminal,
                                                  sales_value)
                    SELECT items_id,
                           nuNuevaLista,
                           price,
                           SYSDATE,
                           sbUSUARIO,
                           sbTERMINAL,
                           sales_value
                      FROM GE_UNIT_COST_ITE_LIS
                     WHERE list_unitary_cost_id = nuList_unitary_cost_id;


                pkg_Traza.Trace (SQL%ROWCOUNT);
            END IF;

            COMMIT;
        ELSE
            /*se realiza la asociaci?n de la nueva localidad al tipo de lista */
            INSERT INTO LDC_LOC_TIPO_LIST_DEP
                 VALUES (inuTipListDes, nuDepartamento, inuLocalidad);

            COMMIT;


            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'Se hizo la asociaci?n pero no se pudo actualizar la lista de costos');
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
    END AsociarLocalidadLista;



    PROCEDURE CambiaTipoListaLocalidad (inuLocalidad     NUMBER,
                                        inuTipListDes    NUMBER,
                                        isbDescripcion   VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CambiaTipoListaLocalidad';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
        
        nuExiste                        NUMBER;
        nuDepartamento                  ge_geogra_location.geo_loca_father_id%TYPE;
        nuList_unitary_cost_id          GE_LIST_UNITARY_COST.list_unitary_cost_id%TYPE;
        nuNuevaLista                    NUMBER;
        sbUSUARIO                       VARCHAR2 (40) := USER;
        sbTERMINAL                      VARCHAR2 (60) := USERENV ('TERMINAL');
        sbDesListaCosto                 VARCHAR2 (200);
        nuList_unitary_cost_id_Actual   NUMBER;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        -- Valida que la localidad esta asociada a un tipo de lista
        IF (NOT fblExisteLocalidad (inuLocalidad))
        THEN
            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'La localidad no esta asociada a un tipo de lista. Cambie la opcion seleccionada.');
        END IF;

        /*Validar que el tipo de lista destino seleccionada,
        se encuentre configurada para el departamento al cual pertenece la localidad.*/
        --begin
        SELECT geo_loca_father_id
          INTO nuDepartamento
          FROM ge_geogra_location
         WHERE geograp_location_id = inuLocalidad;


        BEGIN
            SELECT 1
              INTO nuExiste
              FROM LDC_TIPO_LIST_DEPART
             WHERE     consecutivo = inuTipListDes
                   AND departamento = nuDepartamento;
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                pkg_error.setErrorMessage (
                    isbMsgErrr =>
                       'No hay lista parametrizada para el departamento('
                    || nuDepartamento
                    || ') al que pertenece la localidad('
                    || inuLocalidad
                    || ')');
        END;

        -- Se busca una localidad que se encuentre asociada al tipo de lista y se arma descripci?n
        nuList_unitary_cost_id :=
            fnuListaPrecioAfin (2, inuTipListDes, inuLocalidad);

        IF (nuList_unitary_cost_id IS NOT NULL)
        THEN
            -- borrando previamente la lista de precios de ?tems que tenga la lista de costos actualmente
            SELECT *
              INTO nuList_unitary_cost_id_Actual
              FROM (  SELECT g.list_unitary_cost_id
                        FROM GE_LIST_UNITARY_COST g
                       WHERE geograp_location_id = inuLocalidad
                    ORDER BY g.validity_final_date DESC,
                             g.list_unitary_cost_id DESC)
             WHERE ROWNUM = 1;


            IF (nuList_unitary_cost_id <> nuList_unitary_cost_id_Actual)
            THEN
                /*se realiza la asociaci?n de la nueva localidad al tipo de lista */
                UPDATE LDC_LOC_TIPO_LIST_DEP
                   SET tipo_lista = inuTipListDes
                 WHERE     departamento = nuDepartamento
                       AND localidad = inuLocalidad;


                -- se obtienen datos previos
                FOR del
                    IN (SELECT ITEMS_ID, PRICE, SALES_VALUE
                          FROM GE_UNIT_COST_ITE_LIS
                         WHERE List_Unitary_Cost_Id =
                               nuList_unitary_cost_id_Actual)
                LOOP
                    DELETE GE_UNIT_COST_ITE_LIS
                     WHERE List_Unitary_Cost_Id =
                           nuList_unitary_cost_id_Actual;


                    -- se valida si hay observaci?n, sino se envia nombre de FORMA
                    PKG_LDC_ITEMS_AUDIT.PRINSERTAR (
                        nuList_unitary_cost_id_Actual,
                        del.ITEMS_ID,
                        del.PRICE,
                        NULL,
                        del.SALES_VALUE,
                        NULL,
                        'LDCASOCAMLTL',
                        'E');
                END LOOP;


                DELETE FROM
                    GE_LIST_UNITARY_COST g
                      WHERE List_Unitary_Cost_Id =
                            nuList_unitary_cost_id_Actual;


                -- Se crea la nueva lista y se arma la descripci?n
                sbDesListaCosto :=
                    fsbDescripcionLista (inuLocalidad,
                                         inuTipListDes,
                                         isbDescripcion);

                SELECT SEQ_GE_LIST_UNITARY_COST.NEXTVAL
                  INTO nuNuevaLista
                  FROM DUAL;


                INSERT INTO GE_LIST_UNITARY_COST (list_unitary_cost_id,
                                                  description,
                                                  validity_start_date,
                                                  validity_final_date,
                                                  user_id,
                                                  terminal,
                                                  geograp_location_id)
                    SELECT nuNuevaLista,
                           sbDesListaCosto,
                           Validity_Start_Date,
                           Validity_Final_Date,
                           sbUSUARIO,
                           sbTERMINAL,
                           inuLocalidad
                      FROM GE_LIST_UNITARY_COST
                     WHERE List_Unitary_Cost_Id = nuList_unitary_cost_id;


                -- Se adiciona el item
                INSERT INTO GE_UNIT_COST_ITE_LIS (items_id,
                                                  list_unitary_cost_id,
                                                  price,
                                                  last_update_date,
                                                  user_id,
                                                  terminal,
                                                  sales_value)
                    SELECT items_id,
                           nuNuevaLista,
                           price,
                           SYSDATE,
                           sbUSUARIO,
                           sbTERMINAL,
                           sales_value
                      FROM GE_UNIT_COST_ITE_LIS
                     WHERE list_unitary_cost_id = nuList_unitary_cost_id;

                COMMIT;
            END IF;
        ELSE
            /*se realiza la asociaci?n de la nueva localidad al tipo de lista */
            UPDATE LDC_LOC_TIPO_LIST_DEP
               SET tipo_lista = inuTipListDes
             WHERE departamento = nuDepartamento AND localidad = inuLocalidad;

            COMMIT;


            pkg_error.setErrorMessage (
                isbMsgErrr =>
                'Se hizo el cambio de tipo de lista pero no se pudo actualizar la lista de costos');
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
    END CambiaTipoListaLocalidad;

    PROCEDURE OperacionesLocaTipLista
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'OperacionesLocaTipLista';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);       
    
        nuOpcion        NUMBER;
        nuLocalidad     NUMBER;
        nuTipListDes    NUMBER;
        sbDescripcion   VARCHAR2 (200);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        /* obtener los valores ingresados en la aplicacion PB LDCCAIPA */
        nuOpcion :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL_TYPE',
                                                   'CAUSAL_TYPE_ID');
        nuLocalidad :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION',
                                                   'GEOGRAP_LOCATION_ID');
        nuTipListDes :=
            ge_boInstanceControl.fsbGetFieldValue (
                'LDC_LOC_TIPO_LIST_DEP',
                'TIPO_LISTA');
        sbDescripcion :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL',
                                                   'DESCRIPTION');


        IF (nuOpcion = 1)
        THEN
            AsociarLocalidadLista (nuLocalidad,
                                   nuTipListDes,
                                   sbDescripcion);
        ELSE
            CambiaTipoListaLocalidad (nuLocalidad,
                                      nuTipListDes,
                                      sbDescripcion);
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
    END OperacionesLocaTipLista;
END LDC_ARCHTIPO_LISTA;
/

