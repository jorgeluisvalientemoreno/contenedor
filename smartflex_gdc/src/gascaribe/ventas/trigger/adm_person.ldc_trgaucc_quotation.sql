CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGAUCC_QUOTATION 
  AFTER UPDATE OF status ON cc_quotation 
  FOR EACH ROW 
    /***************************************************************** 
    Propiedad intelectual de Gases del Caribe. 

    Nombre del Objeto: ldc_trgaucc_quotation 
    Descripción:        Actualizar el estado de la cotización detallada cuando esta se apruebe 

    Autor    : Sandra Muñoz 
    Fecha    : 29-06-2016 

    Historia de Modificaciones 

    DD-MM-YYYY    <Autor>.              Modificación 
    -----------  -------------------    ------------------------------------- 
    29-06-2016   Sandra Muñoz           Creación 
    18-11-2016   KCienfuegos.CA200-535  Se actualiza el estado de la cotizacion comercial 
    ******************************************************************/ 

DECLARE
    cnuErrorNumber             CONSTANT NUMBER := 2741; 
    nuExiste                   NUMBER:=0; 
    nuProyecto                 ldc_proyecto_constructora.id_proyecto%TYPE; -- Proyecto 
    nuCotizacionDetalladaAprobada ldc_cotizacion_construct.id_cotizacion_detallada%TYPE; -- Cotización detallada aprobada 
    nuCotizacionComercial      ldc_cotizacion_comercial.id_cot_comercial%TYPE; --Id cotización comercial 

    CURSOR cuObtieneCotizacion IS 
      SELECT cc.id_cotizacion_detallada,  cc.id_proyecto 
        FROM ldc_cotizacion_construct cc 
       WHERE cc.id_cotizacion_osf = :new.quotation_id; 

    CURSOR cuObtieneCotizacionCom IS
     SELECT c.id_cot_comercial
       FROM ldc_cotizacion_comercial c
      WHERE c.sol_cotizacion = :new.package_id;

    CURSOR cuObtieneOrden IS 
      SELECT COUNT(1) 
        FROM or_order_activity oa, or_order o 
       WHERE package_id = :new.package_id 
         AND o.order_id = oa.order_id 
         AND o.order_status_id IN(OR_boconstants.cnuORDER_STAT_REGISTERED, or_boconstants.cnuORDER_STAT_ASSIGNED); 

BEGIN 

    -- Si se está aprobando la cotización 
    IF :new.Status = 'A' THEN 

        -- Determina cual es la cotización preaprobada 
        OPEN cuObtieneCotizacion; 
        FETCH cuObtieneCotizacion INTO nuCotizacionDetalladaAprobada, nuProyecto; 
        CLOSE cuObtieneCotizacion; 

        IF(nuCotizacionDetalladaAprobada IS NOT NULL AND nuProyecto IS NOT NULL) THEN 
         OPEN cuObtieneOrden; 
         FETCH cuObtieneOrden INTO nuExiste; 
         CLOSE cuObtieneOrden;

         IF(nuExiste>0)THEN 
               errors.seterror(cnuErrorNumber, 'Se requieren legalizar las órdenes pendientes para poder aprobar la cotización'); 
               RAISE ex.controlled_error; 
         END IF; 

         -- Actualiza el estado de la cotización detallada
         daldc_cotizacion_construct.updESTADO(inuid_cotizacion_detallada => nuCotizacionDetalladaAprobada,
                                              inuid_proyecto             => nuProyecto,
                                              isbestado$                 => ldc_bocotizacionconstructora.csbCotizacionAprobada);
        ELSE

         OPEN cuObtieneCotizacionCom;  
         FETCH cuObtieneCotizacionCom INTO nuCotizacionComercial; 
         CLOSE cuObtieneCotizacionCom; 

         IF(nuCotizacionComercial IS NOT NULL)THEN 
           daldc_cotizacion_comercial.updESTADO(inuID_COT_COMERCIAL => nuCotizacionComercial,
                                                isbESTADO$ => :new.Status);
         END IF; 
       END IF;
    END IF;

EXCEPTION 
 WHEN ex.CONTROLLED_ERROR 
   THEN RAISE ex.CONTROLLED_ERROR; 
 WHEN OTHERS THEN 
   NULL; 
END LDC_TRGAUCC_QUOTATION; 
/
