CREATE OR REPLACE PROCEDURE adm_person.ldc_pGenerateBillprep
(
    inuContract     IN      open.suscripc.susccodi%type
)
/**************************************************************************
Propiedad Intelectual de Gases del Caribe SA ESP
 Nombre: ldc_pGenerateBillprep
 Autor:IBECERRA
 Fecha:02-05-2022
 Descripcion: PLUGIN para generar las cuentas de cobro cuando se hace una instalacion
              de medidor prepago
 Historial
Autor       Fecha       Caso      Descripcion
PAcosta     23/07/2024  OSF-2952  Cambio de esquema ADM_PERSON 
GDGuevara   19/07/2024  OSF-2959  Se homologa parte del codigo para cumplir pautas de version 8.0
GDGuevara   17/07/2024  OSF-2959  Se elimina el bloque de codigo donde ejecuta:
                                  ldc_boDiferidosPasoPrepago.pCreaPeriGraciaDifePlanContin
                                  pktblsuscripc.updsuscnupr(inuContract, 2)
                                  pkFgca.SETDOCOMMIT(FALSE )
                                  pkFgca.liqbycontract
                                  pktblsuscripc.updsuscnupr(inuContract, 0);
                                  pkg_Error.setApplication('FGCC');
                                  pktblsuscripc.updsuscnupr(inuContract, 2);
                                  pkGenerateBill.generate
                                  pktblsuscripc.updsuscnupr(inuContract, 0);
jcatuchemvm 14-07-2023  OSF-825   Se agrega llamado a procedimientos del paquete pkBORatingMemoryMgr
                                  y a Pkinstancedatamgr para limpiar data en cache y en instancia 
                                  que estaba afectando la liquidación por contrato que se hace en el pluggin.
                                  Se ajustan llamados a pkerror por los correspondientes en pkg_Error.
jpinedc     19-12-2022  OSF-740   Se ejecuta pkFgca.SETDOCOMMIT antes de
                                  pkFgca.liqbycontract ya que se estaba
                                  haciendo commit por defacto                                    
jpinedc     01-12-2022  OSF-740   Se ejecuta ldc_boDiferidosPasoPrepago.
                                  pCreaPeriGraciaDifePlanContin antes de la
                                  generacion de cargos
**************************************************************************/
IS        
    csbMT_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
    cnuProgram          CONSTANT procesos.proccons%type := 97;
    nuCycle             suscripc.susccicl%TYPE;
    nuProcess           procesos.proccons%type := 42;
    nuTypeDocu          ge_document_type.document_type_id%type := 66;
    nuProduct           servsusc.sesunuse%type;
    nuContract          suscripc.susccodi%type;
    nuErrorCode         ge_error_log.error_log_id%type;
    sbErrorMessage      ge_error_log.description%type;
    cnuPlanPrepago      CONSTANT servsusc.sesuplfa%TYPE := pkg_bcld_Parameter.fnuObtieneValorNumerico('PLAN_FACTU_MEDIDOR_PREPAGO');--57;
    
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    
    CURSOR CUPROD (nuContrato IN servsusc.sesususc%TYPE)
    IS
    SELECT sesunuse
      FROM servsusc
     WHERE sesususc =  nuContrato
       AND sesuserv = 7014;
    CURSOR CUELEMMEDI (nuProducto IN ELMESESU.EMSSSESU%TYPE)
    IS
        SELECT
               /*+ leading(elmesesu)
                   use_nl(elmesesu elemmedi) */
              ELEMMEDI.ELMEIDEM
        FROM  ELMESESU,
              ELEMMEDI
              /*+ pkBCElemMedi.getElemMediByProduct SAO186913 */
        WHERE ELMESESU.EMSSSESU = nuProducto
          AND ELMESESU.EMSSFEIN <= SYSDATE
          AND ELMESESU.EMSSFERE > SYSDATE
          AND ELMESESU.EMSSELME = ELEMMEDI.ELMEIDEM
        ORDER BY ELEMMEDI.ELMEPOSI;

BEGIN
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('Contrato: ['||inuContract||']', pkg_traza.cnuNivelTrzDef);
    
    --Limpia información de cargos en cache
    pkBORatingMemoryMgr.CLEARPRODUCTCACHE;
    pkBORatingMemoryMgr.CLEARCONCEPTCACHE;
    --Limpia información instanciada
    pkBORatingMemoryMgr.CLEARINSTANCEDATAPRO;
    pkBORatingMemoryMgr.CLEARINSTANCEDATACNC;
    Pkinstancedatamgr.SETTG_SUPPDOC(NULL);

    pkg_Error.setApplication('FGCA');
    nuContract := inuContract;
    
    if pkg_bccontrato.fnuCodigoProcFacturacion(inuContract) =  2 then
        pkg_Error.setErrorMessage
        (
            isbMsgErrr => 'Se estan generando cuentas de cobro, intente mas tarde'
        );
    end if;

    nuProduct := 0;
    OPEN cuProd(nuContract);
    FETCH cuProd INTO nuProduct;
    CLOSE cuProd;

    IF (nuProduct > 0 OR nuProduct IS not null) THEN

        pktblServsusc.UPDSESUPLFA(nuProduct, cnuPlanPrepago);
        DAPR_product.UPDCOMMERCIAL_PLAN_ID(nuProduct, cnuPlanPrepago);

        FOR rcelemmedi in CUELEMMEDI(nuProduct) loop
            pktblElemmedi.UPDELMECLEM(rcelemmedi.ELMEIDEM,CM_BCConstants.CNUMACRO_MED_TELEMEDIDO );
        END LOOP;
    END IF;

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
       
EXCEPTION
    -- Validacion de error controlado
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError,sbError);
      pkg_traza.trace('sbError: '||sbError, pkg_traza.cnuNivelTrzDef);      
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
    -- Validacion de error no controlado
      pkg_Error.setError;
      pkg_Error.getError(nuError,sbError);
      pkg_traza.trace('sbError: '||sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);      
      RAISE pkg_Error.Controlled_Error;            
END ldc_pGenerateBillprep;
/
PROMPT Otorgando permisos de ejecucion a LDC_PGENERATEBILLPREP
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PGENERATEBILLPREP', 'ADM_PERSON');
END;
/