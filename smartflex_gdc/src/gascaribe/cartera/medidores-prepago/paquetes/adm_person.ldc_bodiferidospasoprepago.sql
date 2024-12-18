CREATE OR REPLACE PACKAGE adm_person.ldc_boDiferidosPasoPrepago IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    ldc_boDiferidosPasoPrepago
    Autor       :   Lubin Pineda - MVM
    Fecha       :   01-12-2022
    Descripcion :   Paquete con los objetos del negocio para el manejo de los
                    diferidos cuando un producto pasa a prepago
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     01-12-2022  OSF-740 Creacion
    PAcosta     19/06/2024  OSF-2845: Cambio de esquema ADM_PERSON
*******************************************************************************/

    -- Crea Periodos de Gracia para Diferidos con Planes de Contingencia
    PROCEDURE pCreaPeriGraciaDifePlanContin
    (
        inuContrato diferido.difesusc%TYPE
    );

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

END ldc_boDiferidosPasoPrepago;
/

CREATE OR REPLACE PACKAGE BODY adm_person.ldc_boDiferidosPasoPrepago IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-740';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'ldc_boDiferidosPasoPrepago.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;

    -- Periodo de gracia por paso a prepago
    cnuPERI_GRAC_PREP          CONSTANT cc_grace_period.grace_period_id%TYPE := 45;
    
    -- Dias de gracia del periodo
    cnuDIAS_GRACIA             CONSTANT cc_grace_period.Max_Grace_Days%TYPE := dacc_grace_period.fnuGetMax_Grace_Days( cnuPERI_GRAC_PREP );   
    
    -- Codigo proceso FIRPG	- Registro de Periodos de Gracia por Diferido
    cnuFIRPG                    CONSTANT procesos.proccons%TYPE := 309;
    
    -- Obtiene los diferidos del contrato con saldo y de planes de alivio 
    -- por contingencia
    CURSOR cuDiferidosContingencia
    ( 
        inuContrato diferido.difesusc%TYPE,
        inuUltiDife diferido.difecodi%TYPE
    ) 
    IS
    WITH pldicont AS
    (
        SELECT plficoco plan_id
        FROM LDC_CONFIG_CONTINGENC
        UNION 
        SELECT plficont plan_id
        FROM LDC_CONFIG_CONTINGENC            
    )
    SELECT difecodi
    FROM diferido df, pldicont
    WHERE df.difesusc = inuContrato
    AND NVL( df.difesape,0 ) > 0
    AND df.difepldi = pldicont.plan_id
    AND df.difecodi > inuUltiDife
    AND NOT EXISTS
    (
        SELECT '1'
        FROM cc_grace_peri_defe pg
        WHERE pg.deferred_id = df.difecodi
        AND pg.grace_period_id = cnuPERI_GRAC_PREP
        AND SYSDATE between pg.INITIAL_DATE AND pg.END_DATE
    )
    ORDER BY difecodi;
    
    -- Tipo tabla pl para cuDiferidosContingencia
    TYPE tytbDiferidosContingencia IS TABLE OF cuDiferidosContingencia%ROWTYPE 
    INDEX BY BINARY_INTEGER;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftbDiferidosContingencia 
    Descripcion     : Retorna una tabla pl con los diferidos con saldo del contrato
                      que tengan plan de alivio por contingencia
    Autor           : Lubin Pineda - MVM 
    Fecha           : 01-12-2022 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     01-12-2022  OSF-740 Creacion
    ***************************************************************************/                     
    FUNCTION ftbDiferidosContingencia 
    ( 
        inuContrato     diferido.difesusc%TYPE,
        inuUltiDifeProc diferido.difecodi%TYPE
    )
    RETURN tytbDiferidosContingencia
    IS
        -- Nombre de ste mtodo
        csbMT_NAME  VARCHAR2(30) := 'ftbDiferidosContingencia';
            
        tbDiferidosConti   tytbDiferidosContingencia;      
    BEGIN

        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);    
    
        OPEN cuDiferidosContingencia( inuContrato, inuUltiDifeProc );
        FETCH cuDiferidosContingencia BULK COLLECT INTO tbDiferidosConti LIMIT 1000;
        CLOSE cuDiferidosContingencia;    
 
        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC); 
        
        RETURN tbDiferidosConti;   
   
    END ftbDiferidosContingencia;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pCreaPeriGraciPrepaDife 
    Descripcion     : Crea un periodo de gracia para el diferido de tipo 45                       
    Autor           : Lubin Pineda - MVM 
    Fecha           : 01-12-2022 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     01-12-2022  OSF-740 Creacion
    ***************************************************************************/   
    PROCEDURE pCreaPeriGraciPrepaDife
    (
        inuDiferido diferido.difecodi%TYPE
    )
    IS
        -- Nombre de ste mtodo
        csbMT_NAME      VARCHAR2(30) := 'pCreaPeriGraciPrepaDife';
                
        rcCC_Grace_Peri_Defe    DACC_Grace_Peri_Defe.styCC_Grace_Peri_Defe;
                
    BEGIN
    
        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC); 
                    
        rcCC_Grace_Peri_Defe.Grace_Peri_Defe_Id :=  SEQ_CC_GRACE_PERI_D_185489.NextVal;
        rcCC_Grace_Peri_Defe.Grace_Period_id    :=  cnuPERI_GRAC_PREP;
        rcCC_Grace_Peri_Defe.Deferred_id        :=  inuDiferido;
        rcCC_Grace_Peri_Defe.Initial_Date       :=  TRUNC(SYSDATE);
        rcCC_Grace_Peri_Defe.End_Date           :=  TRUNC(SYSDATE) + cnuDIAS_GRACIA;
        rcCC_Grace_Peri_Defe.Program            :=  cnuFIRPG; 
        rcCC_Grace_Peri_Defe.Person_Id          :=  GE_BOPersonal.fnuGetPersonId;        
        
        DACC_Grace_Peri_Defe.insRecord( rcCC_Grace_Peri_Defe );

        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);    

    END pCreaPeriGraciPrepaDife;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pCreaPeriGraciPrepaDife 
    Descripcion     : Crea periodos de gracias para los diferidos con saldo del 
                      contrato
    Autor           : Lubin Pineda - MVM 
    Fecha           : 01-12-2022 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     01-12-2022  OSF-740 Creacion
    ***************************************************************************/
    PROCEDURE pCreaPeriGraciaDifePlanContin
    (
        inuContrato diferido.difesusc%TYPE
    )
    IS
        -- Nombre de ste mtodo
        csbMT_NAME  VARCHAR2(30) := 'pCreaPeriGraciaDifePlanContin';
        
        tbDiferidosContingencia   tytbDiferidosContingencia;
        
        nuUltiDifeProc          diferido.difecodi%TYPE := -1;          
                
    BEGIN
    
        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);    

        LOOP
        
            tbDiferidosContingencia := ftbDiferidosContingencia( inuContrato, nuUltiDifeProc );
            
            EXIT WHEN tbDiferidosContingencia.COUNT = 0;

            FOR indtbDife IN 1..tbDiferidosContingencia.Count LOOP
                pCreaPeriGraciPrepaDife( tbDiferidosContingencia(indtbDife).difecodi );
            END LOOP;
            
            nuUltiDifeProc := tbDiferidosContingencia ( tbDiferidosContingencia.COUNT ).difecodi;

        END LOOP;
        
        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
        WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR OR pkConstante.exERROR_LEVEL2 THEN
            ut_trace.trace('Error Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            RAISE;
        WHEN OTHERS THEN
            ut_trace.trace('Error No Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;     
    END pCreaPeriGraciaDifePlanContin;
   
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 01-12-2022 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     01-12-2022  OSF-740 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
END ldc_boDiferidosPasoPrepago;
/
PROMPT Otorgando permisos de ejecucion a LDC_BODIFERIDOSPASOPREPAGO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BODIFERIDOSPASOPREPAGO', 'ADM_PERSON');
END;
/
