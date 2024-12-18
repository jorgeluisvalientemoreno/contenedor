create or replace PACKAGE LDC_BOSUSPENSIONS
IS
/*****************************************************************
Propiedad intelectual PETI (c).

Unidad         : LDC_BOSUSPENSIONS
Descripcion    : Paquete con logica usada en el proceso de suspension total
                 y suspension voluntaria.
Autor          :
Fecha          : 29/05/2013

Historia de Modificaciones
Fecha	    IDEntrega
==========  =================   ============================================
02/09/2021  HT 829              se modifico la funcion fsbGenRecoVolAcom  y se valida que la ultima actividad de suspension este en el parametro
                                LDC_CODACTISUSPACOM
26/04/2023  jpinedc.OSF-1048    Se modifica LDC_BOSUSPENSIONS.ProcessNoBill.ProcessProduct 
26/06/2023  jpinedc.OSF-1194    * Se crean pCargaParametros, pIniCadenaJobsPBMAFA, 
                                pHiloCadenaJobsPBMAFA, pFinCadenaJobsPBMAFA, pCargTablaProgCadenaJobsPBMAFA
                                pCreaReglasCadenaJobsPBMAFA, pCreaCadenaJobsPBMAFA, pDefValArgsCadenaJobsPBMAFA,
                                pActivaCadenaJobsPBMAFA , pProcMasivoPBMAFA pProcIndivPBMAFA
                                * Se modifica LDC_BOSUSPENSIONS.ProcessNoBill
05/07/2023  jpinedc.OSF-1194    * Se cambia ldc_scheduler por pkg_scheduler                                     
26/07/2023  jpinedc.OSF-1194    * Ajustes por hallazgos en pruebas de QA 
13/09/2023  jpinedc.OSF-1558    * Ajuste pProcMasivoPBMAFA                      
17/11/2023  jpinedc.OSF-1938    * prEnviaEMailSinAdjuntos: Creación
                                * Ajuste pFinCadenaJobsPBMAFA
27/11/2023  jpinedc.OSF-1938    * Ajustes validación técnica  
29/11/2023  jpinedc.OSF-1938    * Ajustes validación técnica 2
22/04/2023  jpinedc.OSF-2580    * Se borra el método prEnviaEMailSinAdjuntos,
                                  Se cambian los llamados a prEnviaEMailSinAdjuntos
                                  por pkg_Correo.prcEnviaCorreo.
                                  Se cambia chr(10) por <br> en los mensajes
16/07/2024  fvalencia.OSF-2752  Se modifica el procedimieno ProcessProduct y se modificacion de 
                                estandares
18/10/2024  fvalencia.OSF-3488  Se modifica el procedimieno ProcessProduct para eliminar la actualización
                                ldc_info_predio y el procedimiento ProcessSuspensionTotalOrder
******************************************************************/

    -- Tipo para los datos de un producto
    type styServsusc IS record
    (
        sesunuse    servsusc.sesunuse%type,
        sesuesco    servsusc.sesuesco%type,
        sesuserv    servsusc.sesuserv%type,
        sesuesfn    servsusc.sesuesfn%type
    );

    -- Tabla PL para los datos de productos
    type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

    -- Obtiene los argumentos de un método
    CURSOR cuArgumentos( isbPack VARCHAR2, isbApi VARCHAR2) IS
    SELECT ARGUMENT_NAME, DATA_TYPE, POSITION, '' VALUE
    FROM user_arguments
    WHERE NVL(PACKAGE_NAME,'-') = NVL(isbPack,'-')
    AND OBJECT_NAME = isbApi
    AND DATA_TYPE IS NOT NULL
    ;
    
    -- Tipo de dato para los argumentos de un método    
    TYPE tytbArgumentos      IS TABLE OF cuArgumentos%ROWTYPE INDEX BY VARCHAR2(100);  

    -- Retorna el id del último caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;
        
    -- Retorna una tabla pl con la información de los argumentos de un metodo        
    FUNCTION ftbArgumentos( isbPack VARCHAR2, isbApi VARCHAR2)
    RETURN tytbArgumentos;    
        
    FUNCTION ldc_fsbCausalSuspVol
    (
	   inuMotive   in     mo_motive.package_id%type
    )
    RETURN number;

    FUNCTION fsbGenRecoVolAcom
    (
    	inuPackage   in   mo_motive.package_id%type
    )
    RETURN number;

    -- Generacion, asignacion y legalizacion ordenes de suspension total
    PROCEDURE  ProcessSuspensionTotalOrder;
    
    -- Actualza el estado de corte de un producto
    PROCEDURE  UpdEstacort (
                            nuProducto      in  servsusc.sesunuse%type,
                            nuEscoRecup     in  servsusc.sesuesco%type,
                            nuEscoNuevo     in  servsusc.sesuesco%type
                           );
                           
    -- Proceso de un producto en PBMAFA
    PROCEDURE  ProcessProduct (
                                NMPAPRODUCT_ID  IN  NUMBER,
                                ircServusc   in  styServsusc,
                                nuTipoProc  in  number,
                                oblUpdEstacort out BOOLEAN
                               );

    PROCEDURE processactuparameter(sbpaparameter VARCHAR2,nmpavalor NUMBER);
                        
    -- Ejecuta el proceso masivo o individual de PBMAFA           
    PROCEDURE ProcessNoBill(nmpaproduct_id pr_product.product_id%TYPE);

    -- Retorna verdadero si el producto tiene cargos pendientes por facturar
    FUNCTION fblValProductBilling
    (
        inuproduct  in NUMBER
    )
    RETURN BOOLEAN;

    -- Retorna verdadero si el estado de corte existe
    FUNCTION fblValEstacort
    (
        inuestacort  in NUMBER
    )
    RETURN BOOLEAN;

    PROCEDURE prvalidestcortprod;

    -- Programa que se ejecuta en el primer paso de la cadena de PBMAFA        
    PROCEDURE pIniCadenaJobsPBMAFA;

    -- Programa que se ejecuta en cada hilo de la cadena de PBMAFA      
    PROCEDURE pHiloCadenaJobsPBMAFA( inuEsPrProg NUMBER,inuCantHilos NUMBER, inuHilo NUMBER);

    -- Programa que se ejecuta en el último paso de la cadena de PBMAFA
    PROCEDURE pFinCadenaJobsPBMAFA( inuEsPrProg IN NUMBER);
    
    -- Crea la cadena de Jobs del proceso masivo de PBMAA
    PROCEDURE pCreaCadenaJobsPBMAFA;
    
    -- Proceso masivo de PBMAFA
    PROCEDURE pProcMasivoPBMAFA;
    
END LDC_BOSUSPENSIONS;

/

create or replace PACKAGE BODY LDC_BOSUSPENSIONS
IS

    -- Versión del paquete
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-3488';
    
    -- Para el control de traza:
    csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    CACHE                   CONSTANT NUMBER := 1;   -- Buscar en Cache
    
    gsbProgram           VARCHAR2(2000) := 'PBMAFA';

	-- Declaracion de variables y tipos globales privados del paquete
	gsbChainJobsPBMAFA  VARCHAR2(30) := 'CADENA_JOBS_PBMAFA';
	
    -- Variable para almacenar el valor del parametro
    gnuParamValue        ld_parameter.numeric_value%type;
    
    -- Variable para almacenar el valor del estado de corte a aplicar
    gnuEstacort          ld_parameter.numeric_value%type;

    -- Cuentas de Correo para recibir notificacion
    gsbRecipients        VARCHAR2(2000);
    
    -- Cuenta de Correo para envio de notificacion
    gsbSender            VARCHAR2(2000);
    
    gblpCargaParametros  BOOLEAN := FALSE;
    
    gnuPBMAFA_TOTAL_HILOS   NUMBER;
    
    TYPE TYRCPROGRAMA IS RECORD( 
        PROGRAM_NAME VARCHAR2(100), 
        PACKAGE VARCHAR2(100), 
        API VARCHAR2(100), 
        PROGRAM_TYPE VARCHAR2(50), 
        BLOQUEPL VARCHAR2(4000), 
        STEP VARCHAR2(50),
        PROGRAM_ACTION VARCHAR2(4000) 
    );
    
    RCPROGRAMA TYRCPROGRAMA;
    
    TYPE TYtbSchedChainProg IS TABLE OF TYRCPROGRAMA INDEX BY BINARY_INTEGER;
    
    tbSchedChainProg  TYtbSchedChainProg;
    
    /*******************************************************************************
    Método:         fsbVersion
    Descripción:    Funcion que retorna la csbVersion, la cual indica el último
                    caso que modificó el paquete. Se actualiza cada que se ajusta
                    algún Método del paquete

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada         Descripción
    NA

    Salida          Descripción
    csbVersion      Ultima version del paquete

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;        
    
    /*
        Propiedad intelectual PETI. (c).

        Function	: ldc_fsbCausalSuspVol

        Descripcion	: Determina si el motivo de suspension voluntaria genera orden
                      de suspension a nivel de acometida, dependiendo de la causal
                      de registro de la solicitud

        Parametros	:
    	inuMotivo   Identificador del motivo

        Retorno     :
        boFlag      Indica si la causal genera orden de suspension en acometida

        Autor	: PETI
        Fecha	: <28-05-2013>

        Historia de Modificaciones
        28-05-2013     Creacion

    */        
    PROCEDURE pCargaParametros
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCargaParametros';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        IF NOT gblpCargaParametros THEN
        
            gnuPBMAFA_TOTAL_HILOS := personalizaciones.pkg_parametros.fnuGetValorNumerico('PBMAFA_TOTAL_HILOS');
            pkg_Traza.trace('Parametro PBMAFA_TOTAL_HILOS ['||gnuPBMAFA_TOTAL_HILOS||']', csbNivelTraza );
            if (gnuPBMAFA_TOTAL_HILOS IS NULL OR gnuPBMAFA_TOTAL_HILOS < 1 ) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro PBMAFA_TOTAL_HILOS tiene valor nulo o menor a 1');
            END if;               
                    
            -- Obtiene criterio de cuentas vencidas indicado en el parametro
            gnuParamValue := pkg_bcld_parameter.fnuObtieneValorNumerico('LD_CUENTAS_SUSP_TOTAL');
            pkg_Traza.trace('Parametro LD_CUENTAS_SUSP_TOTAL ['||gnuParamValue||']', csbNivelTraza );
            
            -- Valida que el parametro sea mayor o igual a 1
            if (gnuParamValue < 1 OR gnuParamValue IS NULL) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro LD_CUENTAS_SUSP_TOTAL no posee un valor valido. Ingrese un valor mayor o igual a 1' );
            END if;

            -- Obtiene el estado de corte indicado en el parametro
            gnuEstacort := pkg_bcld_parameter.fnuObtieneValorNumerico('LDC_ESTACORT_SUSP_TOTAL');
            pkg_Traza.trace('Parametro LDC_ESTACORT_SUSP_TOTAL ['||gnuEstacort||']', csbNivelTraza );
            
            if (gnuEstacort < 1 OR gnuEstaCort IS NULL) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro LDC_ESTACORT_SUSP_TOTAL no posee un valor valido. Ingrese un valor mayor o igual a 1' );
            END if;

            if (not fblValEstacort(gnuEstacort)) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El estado de corte indicado en el parametro LDC_ESTACORT_SUSP_TOTAL no existe.');
            END if;
            
            -- Obtiene direcciones de correo para enviar notificacion
            gsbRecipients := pkg_bcld_parameter.fsbObtieneValorCadena('LDC_PBMAFA_RECIPIENTS');
            
            if (gsbRecipients IS NULL) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro LDC_PBMAFA_RECIPIENTS tiene valor nulo.');
            END if;            
            
            gsbSender     := pkg_bcld_parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

            if (gsbSender IS NULL) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro LDC_SMTP_SENDER tiene valor nulo.');
            END if;            
            
            gblpCargaParametros := TRUE;        
        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);        
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_Error.Controlled_Error;                    
    END pCargaParametros;
        	

	-- Definicion de metodos publicos y privados del paquete

    /*
        Propiedad intelectual PETI. (c).

        Function	: ldc_fsbCausalSuspVol

        Descripcion	: Determina si el motivo de suspension voluntaria genera orden
                      de suspension a nivel de acometida, dependiendo de la causal
                      de registro de la solicitud

        Parametros	:
    	inuMotivo   Identificador del motivo

        Retorno     :
        boFlag      Indica si la causal genera orden de suspension en acometida

        Autor	: PETI
        Fecha	: <28-05-2013>

        Historia de Modificaciones
        28-05-2013     Creacion

    */

    FUNCTION ldc_fsbCausalSuspVol
        (
    	inuMotive   in     mo_motive.package_id%type
        )
    RETURN NUMBER 
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'ldc_fsbCausalSuspVol';    
    
        nuCausal        mo_motive.causal_id%type;           -- Variable Causal
        nuMotiv         mo_motive.motive_id%type;           -- Motivo
        nuPackType      mo_packages.package_type_id%type;   -- Tipo de Paquete

        sbLD_CAUS_SUSP_VOL_ACOM ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbObtieneValorCadena('LD_CAUS_SUSP_VOL_ACOM');
        
        -- Almacena en un CURSOR los valores del parametro  LD_CAUS_SUSP_VOL_ACOM
        CURSOR cuParamValues IS                  
        SELECT regexp_substr(sbLD_CAUS_SUSP_VOL_ACOM,'[^,]+', 1, LEVEL) AS COLUMN_VALUE
        FROM dual
        CONNECT BY regexp_substr(sbLD_CAUS_SUSP_VOL_ACOM, '[^,]+', 1, LEVEL) IS NOT NULL;
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                
    --{

        -- Obtiene el ID del Motivo dado el Paquete
        nuMotiv := LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive','package_id','motive_id',inuMotive);

        -- Obtiene el ID del tipo de paquete
        nuPackType := LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_packages','package_id','package_type_id',inuMotive);

        -- Verifica que el tipo de Paquete sea "100209 - SUSPENSION VOLUNTARIA"
        if to_number(nuPackType) != 100209 then
            RETURN(-1);
        end if;

        -- Obtiene la causal de registro de la solicitud dado el motivo
        nuCausal := damo_motive.fnugetcausal_id(nuMotiv);

        -- Determina si la causal corresponde a las indicadas en el parametro
        for reg in cuParamValues loop
            if (nuCausal = to_number(reg.column_value)) then
                RETURN(1);
            end if;
        end loop;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN(0);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_Error.Controlled_Error;
    END ldc_fsbCausalSuspVol;


    /*
        Propiedad intelectual PETI. (c).

        Function	: fsbGenRecoVolAcom

        Descripcion	: Determina si la solicitud de reconexion voluntaria genera orden
                      de reconexion a nivel de acometida, dependiendo del nivel
                      de suspension actual del producto.


        Parametros	:
    	inuMotivo   Identificador del motivo

        Retorno     :
        boFlag      Indica si la causal genera orden de suspension en acometida

        Autor	: PETI
        Fecha	: <28-05-2013>

        Historia de Modificaciones
        28-05-2013     Creacion
        02/09/2021     HT 829 se valida que la ultima actividad de suspension este en el parametro
                       LDC_CODACTISUSPACOM

    */

    FUNCTION fsbGenRecoVolAcom
        (
    	inuPackage   in   mo_motive.package_id%type
        )
    RETURN NUMBER
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'fsbGenRecoVolAcom';    
        nuMotiv         mo_motive.motive_id%type;           -- Motivo
        nuPackType      mo_packages.package_type_id%type;   -- Tipo de Paquete
        nuProductId     pr_product.product_id%type;         -- Producto
        nuSuspAct       pr_product.suspen_ord_act_id%type;  -- Actividad
        nuItemsId       ge_items.items_id%type;             -- Codigo del Item
        --INICIO CA 829
        sbCodactividad VARCHAR2(4000) := pkg_bcld_parameter.fsbObtieneValorCadena('LDC_CODACTISUSPACOM');
        nuConta NUMBER;
        --FIN CA 829
        
        nuError         NUMBER;
        sbError         VARCHAR(4000);
               
        CURSOR cuActiValid
        IS
        SELECT COUNT(1)
        FROM (SELECT to_number(regexp_substr(sbCodactividad,'[^,]+', 1, LEVEL)) AS actividad
             FROM dual
              CONNECT BY regexp_substr(sbCodactividad, '[^,]+', 1, LEVEL) IS NOT NULL)
        WHERE  actividad = nuItemsId;
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'fsbGenRecoVolAcom' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuActiValid%ISOPEN THEN
                CLOSE cuActiValid;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores;
               

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
    --{
        prCierraCursores;
        
         -- Obtiene el ID del Motivo dado el Paquete
        nuMotiv := LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive','package_id','motive_id',inuPackage);

        -- Obtiene el ID del tipo de paquete
        nuPackType := LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_packages','package_id','package_type_id',inuPackage);

        -- Verifica que el tipo de Paquete sea "100210 - RECONEXION VOLUNTARIA"
        if to_number(nuPackType) != 100210 then
            RETURN(-1);
        end if;

        -- Obtiene el producto asociado al motivo
        nuProductId := damo_motive.fnugetproduct_id(nuMotiv);

        -- Obtiene la ultima actividad de suspension del producto
        nuSuspAct := PR_BOSUSPENSION.FNUGETLASTPRODSUSPORDERACTI(nuProductId);

        -- Obtiene el tipo de actividad
        nuItemsId := OR_BOACTIVITIESRULES.FNUGETACTIFROMORDERACT(nuSuspAct);

        OPEN cuActiValid;
        FETCH cuActiValid INTO nuConta;
        CLOSE cuActiValid;
        
        IF nuConta > 0 THEN
            RETURN 1;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN(0);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            prCierraCursores;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                     
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            prCierraCursores;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_Error.Controlled_Error;
    END fsbGenRecoVolAcom;

    /*
    Propiedad intelectual PETI (c).

    Procedure   : ProcessSuspensionTotalOrder

    Descripcion	: Realiza el proceso de generacion, asignacion y legalizacion
                  de las ordenes de suspension total.

    Autor	:
    Fecha	: 30-05-2013

    Historia de Modificaciones
    Fecha	   IDEntrega
    ==========  =================   ============================================
    27/11/2023  jpinedc.OSF-1938    * Ajustes validación técnica 
    21/10/2024  fvalencia.OSF-2488  Se realia modificación del paquete daor_order.getrecord
                                    por pkg_bcordenes.frcgetRecord
    */
    PROCEDURE  ProcessSuspensionTotalOrder
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'ProcessSuspensionTotalOrder';  
            
        rcDataFromMem       pkSuspConnService.tyMemoryVar;          -- registro para obtener los datos de suspecone
        
        nuIdSuspcone        number;                         -- Identificador de la orden SUSPECONE
        nuActivity          ge_items.items_id%type;         -- Id Actividad, Una Actividad esta configurada en la tabla ge_items.
        nuProductId         number;                         -- Identificador del producto
        nuAddressId         number;                         -- Direccion de Instalacion del Producto
        nuOrderTypeBSS      number;                         -- Tipo de orden de BSS

        nuOrderId           OR_order.order_id%type;             -- Id de la orden generada
        nuOrderActivityId   or_order_activity.activity_id%type; -- Id de la actividad de orden generada

        nuOperaUnitID       or_operating_unit.operating_unit_id%type;
        nuPersonId          ge_person.person_id%type;

        nuCausalId          ge_causal.causal_id%type;
        nuCursorPerson      ge_person.person_id%type;

        rcOrder             pkg_bcordenes.styOrden; --OR_order%rowtype;

        sbLegalComment      VARCHAR2(200);

        nuProdSuspenId      NUMBER;
        nuErrorCode         NUMBER;
        sbErrorMess         VARCHAR2(4000);

        -- Almacena en un CURSOR los valores del parametro  LD_LEGAL_SUSP_TOTAL
        sbLD_LEGAL_SUSP_TOTAL ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbObtieneValorCadena('LD_LEGAL_SUSP_TOTAL');
        
        -- Almacena en un CURSOR los valores del parametro  LD_CAUS_SUSP_VOL_ACOM
        CURSOR cuParamValues IS                  
        SELECT regexp_substr(sbLD_LEGAL_SUSP_TOTAL,'[^,]+', 1, LEVEL) AS COLUMN_VALUE, ROWNUM num_row
        FROM dual
        CONNECT BY regexp_substr(sbLD_LEGAL_SUSP_TOTAL, '[^,]+', 1, LEVEL) IS NOT NULL;                  
                  
        -- Almacena el registro del tipo de suspension adicional por suspension total
        CURSOR  cuProdSuspen(product number) IS
        SELECT  prod_suspension_id
        FROM    pr_prod_suspension
        WHERE   product_id = product
                AND suspension_type_id = 6;

        -- Almacena registro de personas que legalizan
        CURSOR  cuPerson(nuOrder number, nuOperatingUnit number) IS
        SELECT  person_id
        FROM    OR_order_person
        WHERE   operating_unit_id = nuOperatingUnit
                AND ORDER_id = nuOrder;
                                
        nuPersonIdLega          ge_person.person_id%type;                
        nuComment_type_id       or_order_comment.comment_type_id%TYPE := 1277;
        dtInitDate              DATE;
        dtFinalDate             DATE;
        dtChangeDate            DATE;        
        sbCadenaLegalizacion    CONSTANTS_PER.TIPO_XML_SOL%TYPE; 
        
        nuError                 NUMBER;
        sbError                 VARCHAR2(4000);
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'ProcessSuspensionTotalOrder' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuProdSuspen%ISOPEN THEN
                CLOSE cuProdSuspen;
            END IF;
            
            IF cuPerson%ISOPEN THEN
                CLOSE cuPerson;
            END IF;
            
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores;                                

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prCierraCursores; 

        --Se Inicializan las Variables de Error
        ge_boutilities.InitializeOutput(nuErrorCode, sbErrorMess);

        -- Obtiene datos instanciados en memoria.
        rcDataFromMem := pkSuspConnService.frcGetInstanceData;

        --Asigna los valores de la instancia.
        nuIdSuspcone        :=  rcDataFromMem.nuIdSuspcone;
        nuActivity          :=  pksuspConnservicemgr.fnuGetActivity;
        nuProductId         :=  rcDataFromMem.nuNumeServ;
        nuOrderTypeBSS      :=  rcDataFromMem.nuOrderType;

        -- Obtiene datos para legalizacion de la orden

        FOR reg IN cuParamValues LOOP
            -- Codigo Unidad de Trabajo
            if (reg.num_row = 1) then
                nuOperaUnitID := reg.column_value;
            -- Persona que legaliza
            elsif (reg.num_row = 2) then
                nuPersonId := reg.column_value;
            -- Causal de Legalizacion
            elsif (reg.num_row = 3) then
                nuCausalId := reg.column_value;
            end if;
        END LOOP;

        -- Evalua que los valores indicados por parametro no sean nulos

        if (nuOperaUnitID IS null OR  nuPersonId IS null OR nuCausalId IS null) then
            pkg_Traza.trace( 'Error! el parametro LD_LEGAL_SUSP_TOTAL tiene valores invalidos', csbNivelTraza );
            pkg_Error.setErrorMessage( 119369, 'LD_LEGAL_SUSP_TOTAL' );
        END if;

        /* Obtiene la direccion de instalacion del producto */
        nuAddressId := PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION(nuProductId);

        -- Se llama al Paquete para Crear Actividades de suspension BSS.
        Or_BoCreatActiProdTypEst.CreateActivity
        (
            nuIdSuspcone,
            nuActivity,
            nuProductId,
            nuOrderTypeBSS,
            nuOrderId,
            nuOrderActivityId,
            TRUE
        );

        -- se obtiene el registro de la orden creada
        rcOrder := pkg_bcordenes.frcgetRecord(nuOrderId);

        -- Realiza llamado al metodo de asignacion sin ninguna validacion
        -- de unidad de trabajo por ser una orden virtual
        API_ASSIGN_ORDER( rcOrder.Order_id, nuOperaUnitID, nuErrorCode, sbErrorMess );
        
        IF nuErrorCode <> 0 THEN
            RAISE pkg_Error.Controlled_Error;
        END IF;

        sbLegalComment := 'LEGALIZACION AUTOMATICA POR SUSPENSION TOTAL VIRTUAL';
             
        open cuPerson(nuOrderId,nuOperaUnitID);
        fetch cuPerson into nuCursorPerson;
        close  cuPerson;

        -- Se actualiza persona que legaliza si no existe
        if (nuCursorPerson IS null) then            
            nuPersonIdLega                  := nuPersonId;
        else
            nuPersonIdLega                  := nuCursorPerson;        
        END if;
        
        pkg_cadena_legalizacion.prSetDatosBasicos
        (
            nuOrderId,
            nuCausalId,
            nuPersonIdLega,
            nuComment_type_id,
            sbLegalComment
        );
        
        pkg_cadena_legalizacion.prAgregaActividadOrden;

        sbCadenaLegalizacion := pkg_cadena_legalizacion.fsbCadenaLegalizacion;
                        
        dtInitDate     := SYSDATE - 0.00138;
        dtFinalDate    := SYSDATE;
        dtChangeDate   := SYSDATE;
            
        api_legalizeorders
        (
            sbCadenaLegalizacion   ,
            dtInitDate             ,
            dtFinalDate            ,
            dtChangeDate           ,
            nuErrorCode             ,
            sbErrorMess
        );

        IF nuErrorCode <> 0 THEN
            RAISE pkg_Error.Controlled_Error;
        END IF;

        -- Extrae ID del tipo de suspension adicional
        open cuProdSuspen(nuProductId);
        fetch   cuProdSuspen INTO nuProdSuspenId;
        close cuProdSuspen;

        -- Elimina informacion del tipo de suspension adicional
        dapr_prod_suspension.delrecord(nuProdSuspenId);
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            prCierraCursores;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                     
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            prCierraCursores;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_Error.Controlled_Error;
    END  ProcessSuspensionTotalOrder;
--}

    /************************************************************************
    Propiedad intelectual PETI (c).

    Procedure   :  UpdEstacort

    Descripcion	:  Realiza el cambio de estado de corte verificando si ha cambiado
                   el estado recuperado respecto al estado en base de datos.

    Autor	: Alejandro Cardenas C.
    Fecha	: 11-11-2014

    Historia de Modificaciones
    Fecha	    IDEntrega
    ==========  =================   ============================================
    11-11-2014  acardenas.NC3485    Creacion.
    */

    PROCEDURE  UpdEstacort (
                            nuProducto      in  servsusc.sesunuse%type,
                            nuEscoRecup     in  servsusc.sesuesco%type,
                            nuEscoNuevo     in  servsusc.sesuesco%type
                           )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'UpdEstacort';      
        nuEscoActual    servsusc.sesuesco%type;
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        -- Se obtiene el estado de corte actual del producto
        nuEscoActual := PKG_BCPRODUCTO.FNUESTADOCORTE(nuProducto); -- Sin acceso a cache

        -- Verifica si el estado de corte actual es igual al recuperado
        if nuEscoRecup = nuEscoActual then
            pkg_Traza.trace( 'Actualiza estado de Corte --> Producto ['||nuProducto, csbNivelTraza );
            pktblservsusc.updsesuesco(nuProducto,nuEscoNuevo);
        END if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);         
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END UpdEstacort;

    /************************************************************************
    Propiedad intelectual PETI (c).

    Procedure   :  ProcessProduct

    Descripcion	:  Realiza el procesamiento por producto.

    Autor	: Alejandro Cardenas C.
    Fecha	: 05-11-2014

    Historia de Modificaciones
    Fecha	    IDEntrega
    ==========  =================   ============================================
    11-11-2014  acardenas.NC3485    Creacion.
    26-04-2023  jpinedc.OSF-1048    Se hace commit solo para el proceso masivo
                                    (cuando nmpaproduct_id = -1)
                                    con el fin de evitar errores en el plugin de
                                    ordenes LDC_PRVALEGAORDENPERSEC
    16-07-2024  felipe.valencia     OSF-2752: Se realiza actualización de predio 
                                    castigado en ldc_info_predio
    16-07-2024  felipe.valencia     OSF-3488: Se elimina la actualización a 
                                    ldc_info_predio
    */

    PROCEDURE  ProcessProduct (
                                NMPAPRODUCT_ID  IN  NUMBER,
                                ircServusc   in  styServsusc,
                                nuTipoProc  in  number,
                                oblUpdEstacort out BOOLEAN
                               )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'ProcessProduct';   
        
        -- Estado de corte previo del producto
        nuPrevEsCo          servsusc.sesuesco%type;
        -- Producto a procesar
        nuNumeServ          servsusc.sesunuse%type;
        -- Estado de Corte del Producto
        nuServEsco          servsusc.sesuesco%type;
        -- Tipo de Producto
        nuTipoProd          servsusc.sesuserv%type;
        -- Estado Financiero
        sbEstaFina          servsusc.sesuesfn%type;
        -- Cuentas vencidas del producto
        nuExpBills          NUMBER;
        -- Suspensiones vigentes
        SbCurrentSuspend    VARCHAR2(2000); 
        
        nuError             NUMBER;
        sbError             VARCHAR2(4000);

        nuDireccion         ab_address.address_id%TYPE;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        pkg_Traza.trace('Procesando Producto ['||ircServusc.sesunuse||']', csbNivelTraza);
        
        oblUpdEstacort := FALSE;

        -- Obtiene criterio de cuentas vencidas indicado en el parametro
        gnuParamValue := pkg_bcld_parameter.fnuObtieneValorNumerico('LD_CUENTAS_SUSP_TOTAL');
        
        -- Obtiene el estado de corte indicado en el parametro
        gnuEstacort := pkg_bcld_parameter.fnuObtieneValorNumerico('LDC_ESTACORT_SUSP_TOTAL');        
        
        -- Valida que el producto no tenga cargos pendientes por facturar
        -- Si tiene cargos pendientes no procesa el producto.

        if not fblValProductBilling(ircServusc.sesunuse) then

            -- Obtiene datos del producto a procesar
            nuNumeServ := ircServusc.sesunuse;
            nuServEsco := ircServusc.sesuesco;
            nuTipoProd := ircServusc.sesuserv;
            sbEstaFina := ircServusc.sesuesfn;
            nuExpBills := pkbccuencobr.fnugetbalaccnum(nuNumeServ);

            pkg_Traza.trace('Datos del Producto...',csbNivelTraza);
            pkg_Traza.trace('Producto ['||nuNumeServ||']',csbNivelTraza);
            pkg_Traza.trace('Estado Corte ['||nuServEsco||']',csbNivelTraza);
            pkg_Traza.trace('Tipo Producto ['||nuTipoProd||']',csbNivelTraza);
            pkg_Traza.trace('Estado Financiero ['||sbEstaFina||']',csbNivelTraza);
            pkg_Traza.trace('Periodos Vencidos ['||nuExpBills||']',csbNivelTraza);

            nuDireccion := pkg_bcproducto.fnuiddireccinstalacion(nuNumeServ);

            pkg_Traza.trace('Direccion del producto ['||nuDireccion||']',csbNivelTraza);

            -- Validaciones para marcar en estado 5
            if  nuTipoProc = 1 then

                -- Si el producto esta EN MORA y cumple con el numero de cuentas
                if(sbEstaFina = 'M' AND nuExpBills >= gnuParamValue) then
                    pkg_Traza.trace('El producto cumple con el # de cuentas ', csbNivelTraza );
                    UpdEstacort(nuNumeServ,nuServEsco,gnuEstacort);
                    oblUpdEstacort := TRUE;

                -- Si el producto esta CASTIGADO y no esta marcado
                elsif(sbEstaFina = 'C' AND nuServEsco <> gnuEstacort) then
                    pkg_Traza.trace('Producto Castigado..', csbNivelTraza );
                    UpdEstacort(nuNumeServ,nuServEsco,gnuEstacort);
                    oblUpdEstacort := TRUE;
                END if;


            -- Validacion para desmarcar producto
            -- si el producto no cumple con el numero de cuentas, no esta castigado y se encuentra marcado
            elsif (nuExpBills < gnuParamValue AND sbEstaFina <> 'C' AND nuServEsco = gnuEstacort) then

                -- Obtiene el estado de corte anterior del producto
                nuPrevEsCo := pkbchicaesco.fnugetprodpreviousstat(nuNumeServ);

                -- Retorna el producto a su estado de corte anterior, siempre que este exista en el historico
                -- de cambios de estado de corte HICAESCO
                if (nuPrevEsco IS not null) then
                    -- Si el estado de corte anterior es 6 - Orden de Conexion.
                    -- Se valida si el producto tiene suspension activa, en ese caso actualiza a 3.
                    SbCurrentSuspend := PR_BOSUSPENSION.FSBVALIDACTIVEPRODSUSP(nuNumeServ,2);

                    if (nuPrevEsco = 6 AND SbCurrentSuspend = 'Y') then
                        pkg_Traza.trace('Producto sin cartera castigada y no cumple con el # de cuentas, se encuentra SUSPENDIDO --> Retorna al estado de corte 3', csbNivelTraza );
                        UpdEstacort(nuNumeServ,nuServEsco,3);
                        oblUpdEstacort := TRUE;
                    END if;

                    if nuPrevEsco <> 6 then
                        pkg_Traza.trace('Producto sin cartera castigada y no cumple con el # de cuentas --> Retorna al estado de corte anterior', csbNivelTraza );
                        UpdEstacort(nuNumeServ,nuServEsco,nuPrevEsCo);
                        oblUpdEstacort := TRUE;
                    END if;
                END if;
            END if;

            pkg_Traza.trace('Termina Producto ['||nuNumeServ||']', csbNivelTraza );
            IF nmpaproduct_id = -1 THEN
                pkgeneralservices.committransaction;
                pkg_Traza.trace('Ejecutó pkgeneralservices.committransaction', csbNivelTraza );
            END IF;
            
        END if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                     
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_Error.Controlled_Error;
    END ProcessProduct;

    PROCEDURE processactuparameter(sbpaparameter VARCHAR2,nmpavalor NUMBER) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'processactuparameter';   
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
        UPDATE ld_parameter
        SET numeric_value = nmpavalor
        WHERE parameter_id  = sbpaparameter;
        COMMIT;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
    END processactuparameter;

    PROCEDURE processactuparameterS(sbpaparameter VARCHAR2,nmpavalor VARCHAR2) IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'processactuparameterS';   
        PRAGMA AUTONOMOUS_TRANSACTION;
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
        UPDATE ld_parameter
        SET value_chain = nmpavalor
        WHERE parameter_id  = sbpaparameter;
        COMMIT;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);  
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                   
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);           
            RAISE pkg_Error.Controlled_Error;                
    END processactuparameterS;
    
    PROCEDURE pProcIndivPBMAFA( nmpaproduct_id NUMBER)
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pProcIndivPBMAFA';    

        blUpdEstaCort       BOOLEAN;

        -- Asunto del correo
        sbSubject           VARCHAR2(2000);
        -- Cuerpo del mensaje
        sbMailMessage       VARCHAR2(2000);

        nuErrorCode         number;
        sbErrorMessage      VARCHAR2(2000);
        nuCount             NUMBER;
        nuRegist            NUMBER;
        nuTotal             NUMBER;
       
        type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

        tbServsusc1  tbtyServsuscTable;
        tbServsusc2  tbtyServsuscTable;


        /* CURSOR 1, productos en mora y castigados propensos a ser marcados. */
        CURSOR cuProductos1(nmcuproduct_id servsusc.sesunuse%TYPE) IS
            SELECT  /*+ index(servsusc IX_SERVSUSC09)
                    */
                   sesunuse, sesuesco, sesuserv, sesuesfn
              FROM servsusc
             WHERE sesuesco in (1,3)
               AND sesuesfn in ('M','C')
			   AND sesunuse = decode(nmcuproduct_id,-1,sesunuse,nmcuproduct_id);

        /* CURSOR 2, productos AL DIA, EN DEUDA o EN MORA marcados con estado 5, propensos
           a ser desmarcados. */
        CURSOR cuProductos2(nmcuproduct_id servsusc.sesunuse%TYPE) IS
            SELECT  /*+ index(servsusc IX_SERVSUSC09)
                    */
                   sesunuse, sesuesco, sesuserv, sesuesfn
              FROM servsusc
             WHERE sesuesco = 5
               AND sesuesfn in ('A','D','M')
			   AND sesunuse = decode(nmcuproduct_id,-1,sesunuse,nmcuproduct_id);
			       
        sbEsPrProg estaprog.esprprog%TYPE;
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'pProcIndivPBMAFA' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuProductos1%ISOPEN THEN
                CLOSE cuProductos1;
            END IF;
            IF cuProductos2%ISOPEN THEN
                CLOSE cuProductos2;
            END IF;            
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores;        
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prCierraCursores; 
            
        pCargaParametros;
                
        -- Inicializa contador de productos procesados
        nuCount  := 0;
        nuRegist := 0;
        nuTotal  := 0;

        -- Establece Ejecutable
        pkg_Error.setApplication(gsbProgram);

        -- Obtiene consecutivo de proceso para Estaprog

        sbEsPrProg := gsbProgram || '-';

        sbEsPrProg :=  pkStatusExeProgramMgr.fsbGetProgramID
                        (
                            sbEsPrProg
                        );

        sbSubject    := 'Inicia ' ||sbEsPrProg ||' - Proceso Individual de Des/Marcacion Productos No Facturables. Producto ' ||nmpaproduct_id;
        sbMailMessage := 'Inicia ejecucion del proceso en el servidor ---> Fecha: '||to_char(sysdate,'dd/mm/yyyy HH:MI:SS am');

        -- Enviar correo inicial    
        pkg_Correo.prcEnviaCorreo
        ( 
            isbRemitente => gsbSender, 
            isbDestinatarios => gsbRecipients, 
            isbAsunto => sbSubject, 
            isbMensaje => sbMailMessage
        );            
                
        -- Inicializa registro en Estaprog
        -- Valida que exista un registro con el	correspondiente key,
        -- si no existe lo crea en la tabla ESTAPROG
        pkStatusExeProgramMgr.ValidateRecordAT (sbEsPrProg);

        -- Inicia Proceso de Marcacion por producto
        pkg_Traza.trace('Inicia Proceso de Marcacion por Producto', csbNivelTraza );

        -- Abre el CURSOR1 de productos y recupera los registros
        open  cuProductos1(nmpaproduct_id);
        fetch cuProductos1 bulk collect INTO tbServsusc1;
        close cuProductos1;

         -- Abre el CURSOR2 de productos y recupera los registros
        open  cuProductos2(nmpaproduct_id);
        fetch cuProductos2 bulk collect INTO tbServsusc2;
        close cuProductos2;

        -- Obtiene el Total de registros a procesar
        nuTotal := NVL(tbServsusc1.last,0) + NVL(tbServsusc2.last,0);

        -- Actualiza registros a Procesar
        -- Inicializa el estado del proceso en ESTAPROG
        pkStatusExeProgramMgr.UpStatusExeProgramAT
        (
                sbEsPrProg,
                'Inicio proceso marcacion individual de productos - PBMAFA',
                nuTotal,
                pkBillConst.CERO
        );

        -- Procesa los productos del cursor1

        if  tbServsusc1.last > 0 then

            for i  in tbServsusc1.first..tbServsusc1.last loop

                -- Realiza el llamado al proceso de marcacion/desmarcacion por producto
                ProcessProduct(nmpaproduct_id, tbServsusc1(i), 1, blUpdEstaCort);
                
                IF blUpdEstaCort THEN
                    nuRegist := nuRegist + 1;
                END IF;
                
                -- Actualiza el estado del proceso en ESTAPROG
                pkStatusExeProgramMgr.UpStatusExeProgramAT
                (
                        sbEsPrProg,
                        'Producto Marcado ['||tbServsusc1(i).sesunuse||']',
                        nuTotal,
                        nuRegist
                );

            END loop;

        END if;

        -- Procesa los productos del cursor2

        if  tbServsusc2.last > 0 then

            for i  in tbServsusc2.first..tbServsusc2.last loop

                -- Realiza el llamado al proceso de marcacion/desmarcacion por producto
                ProcessProduct(nmpaproduct_id,tbServsusc2(i), 2, blUpdEstaCort);
                
                IF blUpdEstaCort THEN
                    nuRegist := nuRegist + 1;
                END IF;

                -- Actualiza el estado del proceso en ESTAPROG
                pkStatusExeProgramMgr.UpStatusExeProgramAT
                (
                        sbEsPrProg,
                        'Producto Desmarcado ['||tbServsusc2(i).sesunuse||']',
                        nuTotal,
                        nuRegist
                );

             END loop;

         END if;
         
        -- Actualiza el estaprog en el campo estasufa
        UPDATE estaprog SET esprsufa = nuRegist 
        WHERE esprprog = sbEsPrProg;             

        COMMIT;

        -- Actualiza el estado del proceso en ESTAPROG
        pkStatusExeProgramMgr.UpStatusExeProgramAT
        (
            sbEsPrProg,
            'Proceso Termino Exitosamente.',
            nuTotal,
            nuTotal
        );

        -- Estructura informacion del correo de finalizacion del proceso
        sbSubject    := 'Finaliza PBMAFA - Proceso Individual de Des/Marcacion Productos No Facturables';
        sbMailMessage := 'Finaliza ejecucion del proceso de manera exitosa ---> Fecha: '||to_char(sysdate,'dd/mm/yyyy HH:MI:SS am');
        sbMailMessage := sbMailMessage||'<br>'||'<br>'||'Total Productos Procesados: '||nuTotal;
        sbMailMessage := sbMailMessage||'<br>'||'Total Productos Actualizados: '||nuRegist;

        -- Enviar correo final
        pkg_Correo.prcEnviaCorreo
        ( 
            isbRemitente => gsbSender, 
            isbDestinatarios => gsbRecipients, 
            isbAsunto => sbSubject, 
            isbMensaje => sbMailMessage
        );            


        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_error.getError(nuErrorCode,sbErrorMessage);
            pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);            
            prCierraCursores;
            sbSubject    := 'ERROR! PBMAFA - Proceso Individual de Des/Marcacion Productos No Facturables';
            sbMailMessage := 'Se presento el siguiente error controlado durante la ejecucion del proceso: '||'<br>';
            sbMailMessage := sbMailMessage||'<<'||sbErrorMessage||'>>';
          
            pkg_Correo.prcEnviaCorreo
            ( 
                isbRemitente => gsbSender, 
                isbDestinatarios => gsbRecipients, 
                isbAsunto => sbSubject, 
                isbMensaje => sbMailMessage
            );            

            -- Actualiza el estado del proceso en ESTAPROG
            pkStatusExeProgramMgr.UpStatusExeProgramAT
            (
                    sbEsPrProg,
                    'Proceso Finalizado con Errores: '||sbMailMessage,
                    nuTotal,
                    nuTotal
            );
            rollback;		
            	
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuErrorCode,sbErrorMessage);
            pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);             
            prCierraCursores;
            sbSubject    := 'ERROR! PBMAFA - Proceso Individual de Des/Marcacion Productos No Facturables';
            sbMailMessage := 'Se presento el siguiente error no controlado durante la ejecucion del proceso: '||'<br>';
            sbMailMessage := sbMailMessage||'<<['||nuErrorCode||'] '||sbErrorMessage||'>>';
            
            pkg_Correo.prcEnviaCorreo
            ( 
                isbRemitente => gsbSender, 
                isbDestinatarios => gsbRecipients, 
                isbAsunto => sbSubject, 
                isbMensaje => sbMailMessage
            );            

            -- Actualiza el estado del proceso en ESTAPROG
            pkStatusExeProgramMgr.UpStatusExeProgramAT
            (
                    sbEsPrProg,
                    'Proceso Finalizado con Errores: '||sbMailMessage,
                    nuTotal,
                    nuTotal
            );
            rollback;			  
    END pProcIndivPBMAFA;

   /*****************************************************************************************
    Propiedad intelectual PETI (c).

    Procedure   : ProcessNoBill

    Descripcion	: Realiza el proceso de marcacion de los productos que no deben
                  facturarse al tener N cuentas vencidas o estar castigados.

    Autor	:
    Fecha	: 16-09-2013

    Historia de Modificaciones
    Fecha	      IDEntrega
    ==========    =================      ============================================
    11/11/2014    acardenas.NC3485       Se divide el CURSOR original en dos cursores
                                         para mejorar el rendimiento.
                                         Se modifica para que se valide si el estado de
                                         corte fue modificado por otro proceso mientras
                                         este proceso estaba en ejecucion.
    02/05/2021	 John J. Jimenez OSF-108 Se cambia la firma y se agrega el parametro
                                         de entrada : nmpaproduct_id(Producto)
                                         Se agrega el parametro de entrada : nmcuproduct_id
                                         a los cursores : cuProductos1 y cuProductos1.
    *****************************************************************************************/

    PROCEDURE ProcessNoBill(nmpaproduct_id pr_product.product_id%TYPE)
    IS

        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'ProcessNoBill';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);   
                    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        IF nmpaproduct_id = -1 THEN
        
            pProcMasivoPBMAFA;
                                
        ELSE

            pProcIndivPBMAFA( nmpaproduct_id);
            
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
    END ProcessNoBill;

    /*
    Propiedad intelectual PETI (c).

    Procedure   : ValParameters

    Descripcion	: Funcion que valida si el producto tiene cargos pendientes por facturar.
                  Retorna TRUE si el producto tiene cargos a la -1.

    Autor	:
    Fecha	: 16-09-2013

    Historia de Modificaciones
    Fecha	   IDEntrega
    ==========  =================   ============================================

    */

    FUNCTION fblValProductBilling
    (
        inuproduct  in NUMBER
    )
    RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'fblValProductBilling';       
        nuFlag      NUMBER;
        blValProductBilling BOOLEAN := FALSE;
        
        CURSOR cuCargPendFact
        IS
        SELECT  COUNT(*)
        FROM    CARGOS
        WHERE   CARGNUSE = inuproduct
                AND CARGCUCO = -1;        
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        PROCEDURE pCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'fblValProductBilling' || '.pCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuCargPendFact%ISOPEN THEN
                CLOSE cuCargPendFact;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END pCierraCursores;        
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pCierraCursores;
        
        OPEN cuCargPendFact;
        FETCH cuCargPendFact INTO nuFlag;
        CLOSE cuCargPendFact;
                           
        blValProductBilling := nuFlag > 0;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN blValProductBilling;          
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error then
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);         
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);             
            RAISE pkg_Error.Controlled_Error;
        when others then
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);             
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);            
            RAISE pkg_Error.Controlled_Error;
    END fblValProductBilling;


    /*
    Propiedad intelectual PETI (c).

    Function   : fblValEstacort

    Descripcion	: Funcion que valida si el estado de corte a aplicar existe en la
                  entidad ESTACORT.

    Autor	:
    Fecha	: 16-09-2013

    Historia de Modificaciones
    Fecha	   IDEntrega
    ==========  =================   ============================================

    */

    FUNCTION fblValEstacort
    (
        inuestacort  in NUMBER
    )
    RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'fblValEstacort';      
        nuFlag      NUMBER;
        blValEstacort   BOOLEAN := FALSE;
        
        CURSOR cuEstaCort
        IS
        SELECT  COUNT(*)
        FROM    estacort
        WHERE   escocodi = inuestacort;  
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);      
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'fblValEstacort' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuEstaCort%ISOPEN THEN
                CLOSE cuEstaCort;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores;
                               
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prCierraCursores; 
                            
        OPEN cuEstaCort;
        FETCH cuEstaCort INTO nuFlag;
        CLOSE cuEstaCort;
        
        blValEstacort := nuFlag > 0;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN blValEstacort;       
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            prCierraCursores;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);         
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            prCierraCursores;            
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END fblValEstacort;


    PROCEDURE  prvalidestcortprod IS
     /*
    Propiedad intelectual Gases del Caribe.

    Function    : prvalidestcortprod

    Descripcion	: Valida que el producto digitado por la forma PBMAFA cumpla
                  con las condiciones para marcación.

    Autor	      : John Jairo Jimenez Mrimon
    Fecha	      : 02-05-2022
    Caso        : OSF-108

    Historia de Modificaciones
    Fecha	   IDEntrega
    ==========  =================   ============================================*/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'prvalidestcortprod';      
        sbproduct_id      ge_boInstanceControl.stysbValue;
        cnunull_attribute CONSTANT NUMBER := 2126;
        sbEstaFina        servsusc.sesuesfn%TYPE;
        nuServEsco        servsusc.sesuesco%TYPE;
        nuEstacort        servsusc.sesuesco%TYPE;
        nuExpBills        NUMBER(10);
        nuNumeServ        servsusc.sesunuse%TYPE;
        ircServusc        servsusc%ROWTYPE;
        nuTipoProd        servsusc.sesuserv%TYPE;
        sbvavalida        VARCHAR2(3);
        nuPrevEsCo        servsusc.sesuesco%type;
        SbCurrentSuspend  VARCHAR2(2000);
        
        nuError           NUMBER;
        sbError           VARCHAR2(4000);  
        
        CURSOR cuServSusc ( inuProducto NUMBER)
        IS
        SELECT *
         FROM servsusc
        WHERE sesunuse = inuProducto;
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'prvalidestcortprod' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuServSusc%ISOPEN THEN
                CLOSE cuServSusc;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores;        
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prCierraCursores;
                            
        sbproduct_id := ge_boInstanceControl.fsbGetFieldValue ('LDC_PLAZOS_CERT', 'ID_PRODUCTO');
        gnuParamValue := pkg_bcld_parameter.fnuObtieneValorNumerico('LD_CUENTAS_SUSP_TOTAL');
        nuEstacort   := pkg_bcld_parameter.fnuObtieneValorNumerico('LDC_ESTACORT_SUSP_TOTAL');
        sbvavalida   := 'NOK';
        
        pCargaParametros;
                
        ------------------------------------------------
        -- Required Attributes -------------------------
        ------------------------------------------------
        IF (sbproduct_id IS NULL) THEN
            pkg_error.SetErrorMessage(cnunull_attribute, 'Producto');
        END IF;
                
         -- Validamos que la ejecución no sea masiva
        IF sbproduct_id <> -1 THEN
            
            OPEN cuServSusc( sbproduct_id);
            FETCH cuServSusc INTO ircServusc;
            CLOSE cuServSusc;
            
            IF ircServusc.sesunuse IS NULL THEN
                pkg_error.SetErrorMessage( isbMsgErrr => 'El codigo digitado no corresponde al de un producto.');
            END IF;
            
            -- Validamos que el producto no tenga pendiente cargos por facturar
            IF NOT fblValProductBilling(sbproduct_id) THEN
                 -- Si el producto esta EN MORA y cumple con el numero de cuentas
                 -- Obtiene datos del producto a procesar
                 nuNumeServ := ircServusc.sesunuse;
                 nuServEsco := ircServusc.sesuesco;
                 nuTipoProd := ircServusc.sesuserv;
                 sbEstaFina := ircServusc.sesuesfn;
                 nuExpBills := pkbccuencobr.fnugetbalaccnum(nuNumeServ);
             
                -- Validaciones que debe cumplir el producto para ser marcado
                IF nuServEsco IN (1,3) THEN
                    IF(sbEstaFina = 'M' AND nuExpBills >= gnuParamValue) THEN
                       sbvavalida := 'OK';
                    ELSIF(sbEstaFina = 'C' AND nuServEsco <> nuEstacort) then
                       sbvavalida := 'OK';
                    ELSE
                       sbvavalida := 'NOK';
                    END if;
                END IF;
           
               -- Validaciones que debe cumplir el producto para ser desmarcado
                IF nuServEsco = 5 THEN
                    IF (nuExpBills < gnuParamValue AND sbEstaFina <> 'C' AND nuServEsco = nuEstacort) then
                         -- Obtiene el estado de corte anterior del producto
                         nuPrevEsCo := pkbchicaesco.fnugetprodpreviousstat(nuNumeServ);
                         -- Retorna el producto a su estado de corte anterior, siempre que este exista en el historico
                         -- de cambios de estado de corte HICAESCO
                        IF (nuPrevEsco IS NOT NULL) THEN
                              -- Si el estado de corte anterior es 6 - Orden de Conexion.
                              -- Se valida si el producto tiene suspension activa, en ese caso actualiza a 3.
                              sbcurrentsuspend := pr_bosuspension.fsbvalidactiveprodsusp(nunumeserv,2);
                            IF (nuPrevEsco = 6 AND SbCurrentSuspend = 'Y') THEN
                              sbvavalida := 'OK';
                            END IF;
                            IF nuPrevEsco <> 6 THEN
                                sbvavalida := 'OK';
                            END IF;
                        END IF;
                    END IF;
                END IF;
           
               IF sbvavalida = 'NOK' THEN
                    pkg_error.SetErrorMessage( isbMsgErrr => 'Producto no cumple las condiciones para ser marcado o desmarcado..favor validar.');
               END IF;
               
            ELSE
                pkg_error.SetErrorMessage( isbMsgErrr => 'El producto tiene cargos pendiente por facturar..no es posible procesarlo.');
            END IF;
            
        ELSE

            IF pkg_scheduler.fblSchedChainRunning( gsbChainJobsPBMAFA ) THEN            
                pkg_error.SetErrorMessage( isbMsgErrr => 'Se está ejecutando el proceso masivo PBMAFA.' );                    
            END IF;
        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);         
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            prCierraCursores;         
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);             
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            prCierraCursores;
            RAISE pkg_Error.Controlled_Error;
    END prvalidestcortprod;
    
    PROCEDURE pIniCadenaJobsPBMAFA
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pIniCadenaJobsPBMAFA';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
                    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);       
        
        RETURN;
        
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
                
    END pIniCadenaJobsPBMAFA;

    PROCEDURE pHiloCadenaJobsPBMAFA( inuEsPrProg NUMBER,inuCantHilos NUMBER, inuHilo NUMBER)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pHiloCadenaJobsPBMAFA';  
        
        blUpdEstaCort       BOOLEAN;

        nuErrorCode         number;
        sbErrorMessage      VARCHAR2(2000);
        
        nuCount             NUMBER;
        nuRegist            NUMBER;
        nuTotal             NUMBER;

        tbServsusc1  tbtyServsuscTable;
        tbServsusc2  tbtyServsuscTable;

        sbEsPrProg          estaprog.esprprog%TYPE;
               
               
        /* CURSOR 1, productos en mora y castigados propensos a ser marcados. */
        CURSOR cuProductos1 IS
            SELECT  /*+ index(servsusc IX_SERVSUSC09)
                    */
                   sesunuse, sesuesco, sesuserv, sesuesfn
              FROM servsusc
             WHERE sesuesco in (1,3)
               AND sesuesfn in ('M','C')
			   AND mod(sesunuse, inuCantHilos )+ 1 = inuHilo;

        /* CURSOR 2, productos AL DIA, EN DEUDA o EN MORA marcados con estado 5, propensos
           a ser desmarcados. */
        CURSOR cuProductos2 IS
            SELECT  /*+ index(servsusc IX_SERVSUSC09)
                    */
                   sesunuse, sesuesco, sesuserv, sesuesfn
              FROM servsusc
             WHERE sesuesco = 5
               AND sesuesfn in ('A','D','M')
			   AND mod(sesunuse, inuCantHilos )+ 1 = inuHilo;
			   
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'pHiloCadenaJobsPBMAFA' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuProductos1%ISOPEN THEN
                CLOSE cuProductos1;
            END IF;
            IF cuProductos2%ISOPEN THEN
                CLOSE cuProductos2;
            END IF;            
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores; 			   
         
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        prCierraCursores; 
                        
        -- Establece Ejecutable
        pkg_Error.setApplication(gsbProgram);

        -- Inicializa contador de productos procesados
        nuCount  := 0;
        nuRegist := 0;
        nuTotal  := 0;

        pCargaParametros;
        
        -- Inicia Proceso de Marcacion por producto
        pkg_Traza.trace('Inicia Proceso Masivo de Des/Marcacion por Producto', csbNivelTraza );
        
        -- Abre el CURSOR1 de productos y recupera los registros
        open  cuProductos1;
        fetch cuProductos1 bulk collect INTO tbServsusc1;
        close cuProductos1;

         -- Abre el CURSOR2 de productos y recupera los registros
        open  cuProductos2;
        fetch cuProductos2 bulk collect INTO tbServsusc2;
        close cuProductos2;

        -- Obtiene el Total de registros a procesar
        nuTotal := NVL(tbServsusc1.last,0) + NVL(tbServsusc2.last,0);
                
        sbEsPrProg := gsbProgram || '-' || inuEsPrProg||'-' ||inuHilo;
                
        -- Inicializa registro en Estaprog
        -- Valida que exista un registro con el	correspondiente key,
        -- si no existe lo crea en la tabla ESTAPROG
        pkStatusExeProgramMgr.ValidateRecordAT (sbEsPrProg);
        
        -- Actualiza el estado del proceso en ESTAPROG
        pkStatusExeProgramMgr.UpStatusExeProgramAT
        (
                sbEsPrProg,
                'Inicio proceso masivo des/marcacion de productos - PBMAFA',
                nuTotal,
                1
        );        

        -- Procesa los productos del cursor1

        if  tbServsusc1.last > 0 then

            for i  in tbServsusc1.first..tbServsusc1.last loop

                -- Realiza el llamado al proceso de marcacion/desmarcacion por producto
                ProcessProduct(-1,tbServsusc1(i), 1, blUpdEstaCort);
                
                IF blUpdEstaCort THEN
                    nuRegist := nuRegist + 1;
                END IF;
                                
                nuCount := nuCount + 1;

                IF mod(nuCount,100) = 0 THEN
                
                    -- Actualiza el estado del proceso en ESTAPROG
                    pkStatusExeProgramMgr.UpStatusExeProgramAT
                    (
                            sbEsPrProg,
                            'Marcando productos...',
                            nuTotal,
                            nuCount
                    );
                    
                END IF;

            END loop;

        END if;

        -- Procesa los productos del cursor2
        if  tbServsusc2.last > 0 then

            for i  in tbServsusc2.first..tbServsusc2.last loop

                -- Realiza el llamado al proceso de marcacion/desmarcacion por producto
                ProcessProduct(-1,tbServsusc2(i), 2, blUpdEstaCort);
                
                IF blUpdEstaCort THEN
                    nuRegist := nuRegist + 1;
                END IF;
                
                nuCount := nuCount + 1;

                IF mod(nuCount,100) = 0 THEN
                
                    -- Actualiza el estado del proceso en ESTAPROG
                    pkStatusExeProgramMgr.UpStatusExeProgramAT
                    (
                            sbEsPrProg,
                            'DesMarcando productos...',
                            nuTotal,
                            nuCount
                    );
                    
                END IF;
                
             END loop;

         END if;
        
        -- Actualiza el estaprog en el campo estasufa
        UPDATE estaprog SET esprsufa = nuRegist 
        WHERE esprprog = sbEsPrProg;
        
        COMMIT;

        -- Actualiza el estado del proceso en ESTAPROG
        pkStatusExeProgramMgr.UpStatusExeProgramAT
        (
            sbEsPrProg,
            'Proceso Termino Exitosamente.',
            nuTotal,
            nuTotal
        );

        pkg_Traza.trace('Finaliza Proceso de Marcacion por Producto', csbNivelTraza );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN            
            pkg_error.getError(nuErrorCode,sbErrorMessage);
            pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);                        
            prCierraCursores;
            -- Actualiza el estado del proceso en ESTAPROG
            pkStatusExeProgramMgr.UpStatusExeProgramAT
            (
                    sbEsPrProg,
                    'Proceso Finalizado con Errores: '||sbErrorMessage,
                    nuTotal,
                    nuTotal
            );
            rollback;			
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuErrorCode,sbErrorMessage);
            pkg_traza.trace(' sbErrorMessage => ' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);             
            prCierraCursores;
            -- Actualiza el estado del proceso en ESTAPROG
            pkStatusExeProgramMgr.UpStatusExeProgramAT
            (
                    sbEsPrProg,
                    'Proceso Finalizado con Errores: '||sbErrorMessage,
                    nuTotal,
                    nuTotal
            );
            rollback;			            
    END pHiloCadenaJobsPBMAFA;
    
    PROCEDURE pFinCadenaJobsPBMAFA( inuEsPrProg IN NUMBER)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pFinCadenaJobsPBMAFA';  
        
        -- Asunto del correo
        sbSubject           VARCHAR2(2000);
        -- Cuerpo del mensaje
        sbMailMessage       VARCHAR2(2000);
        
        sbEsPrProg  estaprog.esprprog%TYPE := gsbProgram || '-' || inuEsPrProg;        
        
        CURSOR cuEstaProg
        IS
        SELECT SUBSTR( esprmesg, 1, INSTR( esprmesg,':') -1 ) mensaje, sum(esprtapr) Total, sum( esprsufa ) Procesados, count(1) Cantidad
        FROM estaprog
        WHERE esprprog LIKE  sbEsPrProg||'-%'
        AND INSTR( esprmesg,':') > 0
        GROUP BY SUBSTR( esprmesg, 1, INSTR( esprmesg,':') -1 )
        UNION ALL
        SELECT  esprmesg mensaje, sum(esprtapr) Total, sum( esprsufa ) Procesados, count(1) Cantidad
        FROM estaprog
        WHERE esprprog LIKE  sbEsPrProg||'-%'
        AND INSTR( esprmesg,':') = 0
        GROUP BY esprmesg        
        ORDER BY 1;
        
        TYPE tytbEstaProg IS TABLE OF cuEstaProg%ROWTYPE INDEX BY BINARY_INTEGER;
        
        tbEstaProg tytbEstaProg;
        
        nuTotal     NUMBER;
        
        sbProceso   varchar2(100) := 'pFinCadenaJobsPBMAFA'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nuCantReg   NUMBER := 1;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME ||  'pFinCadenaJobsPBMAFA' || '.prCierraCursores';           
        BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);         
            IF cuEstaProg%ISOPEN THEN
                CLOSE cuEstaProg;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        END prCierraCursores;        
                    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        prCierraCursores;
        
        pCargaParametros;
               
        OPEN cuEstaProg;
        FETCH cuEstaProg BULK COLLECT INTO tbEstaProg;
        CLOSE cuEstaProg;

        -- Estructura informacion del correo de finalizacion del proceso
        sbSubject    := 'Finaliza ' || sbEsPrProg || ' - Proceso Masivo de Des/Marcacion Productos No Facturables';
        
        IF tbEstaProg.COUNT > 0 THEN
        
            sbMailMessage := tbEstaProg(1).mensaje || ' ---> Fecha: '||to_char(sysdate,'dd/mm/yyyy HH:MI:SS am');        
            CASE tbEstaProg.COUNT 
                WHEN 1 THEN
                    nuTotal := tbEstaProg(1).Total;
                    sbMailMessage := sbMailMessage||'<br>'||'<br>'||'Total Productos Procesados: '|| nuTotal;
                    sbMailMessage := sbMailMessage||'<br>'||'Total Productos Actualizados: '||tbEstaProg(1).Procesados;
                WHEN  2 THEN
                    nuTotal := tbEstaProg(1).Total+tbEstaProg(2).Total;
                    sbMailMessage := sbMailMessage||'<br>'||'<br>'||'Total Productos Procesados: '||( tbEstaProg(1).Total+tbEstaProg(2).Total);
                    sbMailMessage := sbMailMessage||'<br>'||'Total Productos Actualizados: '||(tbEstaProg(1).Procesados+ tbEstaProg(2).Procesados);                
                ELSE
                    sbMailMessage := 'ERROR PBMAFA - Revisar en CCPRO los mensajes de Error en del proceso ' || sbEsPrProg ;
            END CASE;
            
        ELSE
            sbMailMessage := 'ERROR PBMAFA: No se encontraron registros en EstaProg para el proceso ' || sbEsPrProg;
        END IF;

        -- Enviar correo final
        pkg_Correo.prcEnviaCorreo
        ( 
            isbRemitente => gsbSender, 
            isbDestinatarios => gsbRecipients, 
            isbAsunto => sbSubject, 
            isbMensaje => sbMailMessage
        );            
        

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        EXCEPTION
            WHEN pkg_Error.Controlled_Error THEN
                pkg_Error.getError( nuError, sbError);
                pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                 
                prCierraCursores;
                pkg_EstaProc.prInsertaEstaproc ( sbProceso, nuCantReg );
                pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbError );        
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError( nuError, sbError);
                pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                 
                prCierraCursores;
                pkg_EstaProc.prInsertaEstaproc ( sbProceso, nuCantReg );
                pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error', sbError );         
    END pFinCadenaJobsPBMAFA;
    
    FUNCTION fsbAction ( isbPack VARCHAR2, isbApi VARCHAR2 , isbProgType VARCHAR2, isbBloquePl VARCHAR2 ) RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'fsbAction';  
            
        sbAction    VARCHAR2(4000);
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   
    
        CASE isbProgType 
            WHEN 'STORED_PROCEDURE' THEN
                sbAction := ISBPACK || '.' || ISBAPI;
            WHEN 'PLSQL_BLOCK' THEN
                sbAction := isbBloquePl;
        END CASE;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN sbAction;
        
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
    END fsbAction;

    PROCEDURE pCargTablaProgCadenaJobsPBMAFA IS
    
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCargTablaProgCadenaJobsPBMAFA';  
                
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
    
        tbSchedChainProg.DELETE;
        
        RCPROGRAMA.PROGRAM_NAME     := 'INI_' || gsbProgram;
        RCPROGRAMA.PACKAGE          := UPPER('LDC_BOSUSPENSIONS');
        RCPROGRAMA.API              := UPPER('pIniCadenaJobsPBMAFA');
        RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';        
        RCPROGRAMA.STEP             := 'INI_' || gsbProgram;
        RCPROGRAMA.BLOQUEPL         := NULL;
        RCPROGRAMA.PROGRAM_ACTION   := fsbAction ( RCPROGRAMA.PACKAGE , RCPROGRAMA.API  , RCPROGRAMA.PROGRAM_TYPE, RCPROGRAMA.BLOQUEPL );
                                    
        tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
                    
        FOR IND IN 1..gnuPBMAFA_TOTAL_HILOS LOOP
        
            RCPROGRAMA.PROGRAM_NAME := 'PBMAFA_'|| IND;
            RCPROGRAMA.PACKAGE      := UPPER('LDC_BOSuspensions');
            RCPROGRAMA.API          := UPPER('pHiloCadenaJobsPBMAFA');
            RCPROGRAMA.PROGRAM_TYPE := 'STORED_PROCEDURE';                 
            RCPROGRAMA.BLOQUEPL     := NULL;
            RCPROGRAMA.STEP         := 'PBMAFA_'|| IND;
            RCPROGRAMA.PROGRAM_ACTION   := fsbAction ( RCPROGRAMA.PACKAGE , RCPROGRAMA.API  , RCPROGRAMA.PROGRAM_TYPE, RCPROGRAMA.BLOQUEPL );
                                    
            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
            
        END LOOP;
            
        
        RCPROGRAMA.PROGRAM_NAME     := 'FIN_' || gsbProgram;
        RCPROGRAMA.PACKAGE          := UPPER('LDC_BOSuspensions');
        RCPROGRAMA.API              := UPPER('pFinCadenaJobsPBMAFA');
        RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';        
        RCPROGRAMA.STEP             := 'FIN_' || gsbProgram;
        RCPROGRAMA.BLOQUEPL         := NULL;
        
        RCPROGRAMA.PROGRAM_ACTION   := fsbAction ( RCPROGRAMA.PACKAGE , RCPROGRAMA.API  , RCPROGRAMA.PROGRAM_TYPE, RCPROGRAMA.BLOQUEPL );
        
        tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
        
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
    END pCargTablaProgCadenaJobsPBMAFA; 
    
	PROCEDURE pCreaReglasCadenaJobsPBMAFA
	IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaReglasCadenaJobsPBMAFA';
        	
		sbCondicion     VARCHAR2(4000);
		sbAccion        VARCHAR2(4000); 
		
		nuError         NUMBER;
		sbError         VARCHAR2(4000);	
	
	BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
	
		sbCondicion := 'FALSE';
		sbAccion   := 'start INI_' || gsbProgram;
		
		pkg_scheduler.define_chain_rule 
		(
		   gsbChainJobsPBMAFA,
		   sbCondicion,
		   sbAccion
		);
						
		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';
		
		sbAccion    := 'start ';
		
		FOR IND0 IN 1..gnuPBMAFA_TOTAL_HILOS LOOP    
		
			sbAccion   := sbAccion || gsbProgram || '_' || IND0 ;
					
			IF IND0 < gnuPBMAFA_TOTAL_HILOS THEN
				sbAccion := sbAccion ||  ',';                
			END IF;
			
		END LOOP;

		pkg_scheduler.define_chain_rule 
		(
		   gsbChainJobsPBMAFA,                                            
		   sbCondicion,                                    
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';    
					 
		sbAccion := 'start FIN_' || gsbProgram;      
				
		pkg_scheduler.define_chain_rule 
		(
		   gsbChainJobsPBMAFA,
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
		   gsbChainJobsPBMAFA,
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
	END pCreaReglasCadenaJobsPBMAFA;
	
    FUNCTION ftbArgumentos( isbPack VARCHAR2, isbApi VARCHAR2)
    RETURN tytbArgumentos
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'ftbArgumentos';
                    
        tbArgumentos tytbArgumentos;
        
        TYPE tytbArgumentosD IS TABLE OF cuArgumentos%ROWTYPE
        INDEX BY BINARY_INTEGER;
        
        tbArgumentosD tytbArgumentosD;
                
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        	
        pkg_Traza.trace('isbPack|' ||isbPack || '|isbApi|' || isbApi,csbNivelTraza); 
            
        OPEN cuArgumentos( isbPack, isbApi );
        FETCH cuArgumentos BULK COLLECT INTO tbArgumentosD;
        CLOSE cuArgumentos;
        
        pkg_Traza.trace('tbArgumentosD.COUNT|' ||tbArgumentosD.COUNT,csbNivelTraza);         

        IF tbArgumentosD.COUNT > 0 THEN
            FOR ind IN 1..tbArgumentosD.COUNT LOOP
                tbArgumentos( tbArgumentosD(ind).argument_name ) := tbArgumentosD(ind);
            END LOOP;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN tbArgumentos;
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
    END ftbArgumentos;       
    
    PROCEDURE pCreaCadenaJobsPBMAFA
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaCadenaJobsPBMAFA';
            
        nuError NUMBER;
        sbError VARCHAR2(4000);
        
        tbArgumentos  tytbArgumentos;
    
        tbProgramas   pkg_scheduler.tytbProgramas;
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
 	         	        
        pCargTablaProgCadenaJobsPBMAFA;   
    
        IF pkg_scheduler.FBLSCHEDCHAINEXISTS( gsbChainJobsPBMAFA ) THEN        
            pkg_Traza.trace('Ya existe la cadena ' || gsbChainJobsPBMAFA, csbNivelTraza );
            
            tbProgramas := pkg_scheduler.ftbProgramas( gsbProgram );
            
            IF 
            (
                NVL(tbProgramas.Count,0) <> ( gnuPBMAFA_TOTAL_HILOS + 2)
                OR
                pkg_scheduler.fblUltEjecCadJobConError(  gsbChainJobsPBMAFA )
            )
            THEN
                
                pkg_scheduler.pDropSchedChain( gsbChainJobsPBMAFA );
                
                pkg_scheduler.create_chain( gsbChainJobsPBMAFA );
                
            END IF;
             
        ELSE
            pkg_scheduler.create_chain( gsbChainJobsPBMAFA );
        END IF;
            
        FOR indtbPr IN 1..tbSchedChainProg.COUNT LOOP
        
            pkg_Traza.trace('paso|'|| tbSchedChainProg(indtbPr).step, csbNivelTraza );
            pkg_Traza.trace('programa|' || tbSchedChainProg(indtbPr).package || '.' || tbSchedChainProg(indtbPr).api,csbNivelTraza);
        
            tbArgumentos := ftbArgumentos( tbSchedChainProg(indtbPr).package, tbSchedChainProg(indtbPr).api );
        
            pkg_Traza.trace('tbArgumentos.count|' || tbArgumentos.count,csbNivelTraza);
            
            pkg_scheduler.PCREASCHEDCHAINSTEP
            ( 
                gsbChainJobsPBMAFA,
                tbSchedChainProg(indtbPr).step,  
                tbSchedChainProg(indtbPr).program_name,
                tbSchedChainProg(indtbPr).program_type,                     
                tbSchedChainProg(indtbPr).program_action,
                tbArgumentos.count,
                TRUE,
                gsbChainJobsPBMAFA,
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
        
        pCreaReglasCadenaJobsPBMAFA; 
                                              
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
    END pCreaCadenaJobsPBMAFA;
        
    PROCEDURE pDefValArgsCadenaJobsPBMAFA( inuEsPrProg VARCHAR2)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pDefValArgsCadenaJobsPBMAFA';
        tbArgumentos              tytbArgumentos;
        sbIndArg            VARCHAR2(100);
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);                    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        tbArgumentos := ftbArgumentos( 'LDC_BOSUSPENSIONS', UPPER('pHiloCadenaJobsPBMAFA'));
        
        tbArgumentos('INUESPRPROG').VALUE := inuEsPrProg;
        tbArgumentos('INUCANTHILOS').VALUE := gnuPBMAFA_TOTAL_HILOS;
                        
        FOR nuHilo in 1..gnuPBMAFA_TOTAL_HILOS LOOP
        
            tbArgumentos('INUHILO').VALUE := nuHilo;    
        
            sbStep := 'PBMAFA_' || nuHilo;
            
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
        
        tbArgumentos := ftbArgumentos( 'LDC_BOSUSPENSIONS', UPPER('pFinCadenaJobsPBMAFA'));
        
        tbArgumentos('INUESPRPROG').VALUE := inuEsPrProg;
        
        sbStep := 'FIN_PBMAFA';
        
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
    END pDefValArgsCadenaJobsPBMAFA;
        
    PROCEDURE pActivaCadenaJobsPBMAFA
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pActivaCadenaJobsPBMAFA';
        sbStep              VARCHAR2(100);
        nuError             NUMBER;        
        sbError             VARCHAR2(4000);        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                
        sbStep := 'FIN_PBMAFA';
                
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
                
        sbStep := 'INI_PBMAFA';
        
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
            gsbChainJobsPBMAFA,
            nuError,        
            sbError                         
        );
        
        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando la cadena ' || gsbChainJobsPBMAFA );
        ELSE
            pkg_Traza.trace( 'OK Habilitando la cadena ' || gsbChainJobsPBMAFA, csbNivelTraza );
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
    END pActivaCadenaJobsPBMAFA;
    
    PROCEDURE pProcMasivoPBMAFA
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pProcMasivoPBMAFA';
        
        sbEsPrProg         estaprog.esprprog%TYPE;
        
        -- Asunto del correo
        sbSubject           VARCHAR2(2000);
        -- Cuerpo del mensaje
        sbMailMessage       VARCHAR2(2000);
        
        nuEsPrProg          NUMBER;
        
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
                        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                        
        pCargaParametros;
                
        IF pkg_scheduler.fblSchedChainRunning( gsbChainJobsPBMAFA ) THEN            
            pkg_error.SetErrorMessage( NULL, 'La cadena de Jobs ' || gsbChainJobsPBMAFA || ' está corriendo' );                    
        ELSE
                                                                                                    
            pCreaCadenaJobsPBMAFA;

            -- Obtiene consecutivo de proceso para Estaprog
            nuEsPrProg   := sqesprprog.nextval;
                                
            sbEsPrProg := gsbProgram || '-' || nuEsPrProg;                    
            
            pDefValArgsCadenaJobsPBMAFA( nuEsPrProg );
                                
            pActivaCadenaJobsPBMAFA;
                                                                         
            pkg_scheduler.run_chain(gsbChainJobsPBMAFA , 'INI_PBMAFA', 'JOB_' || gsbChainJobsPBMAFA );
            
            -- Obtiene direcciones de correo para enviar notificacion                       
            sbSubject    := 'Inicia ' || sbEsPrProg || ' - Proceso Masivo de Des/Marcacion Productos No Facturables';
            sbMailMessage := 'Inicia ejecucion del proceso en el servidor ---> Fecha: '||to_char(sysdate,'dd/mm/yyyy HH:MI:SS am');
              
            pkg_Correo.prcEnviaCorreo
            ( 
                isbRemitente => gsbSender, 
                isbDestinatarios => gsbRecipients, 
                isbAsunto => sbSubject, 
                isbMensaje => sbMailMessage
            );            
                   
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
    END pProcMasivoPBMAFA;
    
               
END LDC_BOSUSPENSIONS;

/

PROMPT Otorgando permisos de ejecución sobre LDC_BOSUSPENSIONS
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_BOSUSPENSIONS','OPEN');
END;
/

PROMPT Otorgando GRANT EXECUTE ON LDC_BOSUSPENSIONS TO ADM_PERSON
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON LDC_BOSUSPENSIONS TO ADM_PERSON';
END;
/

