CREATE OR REPLACE PACKAGE OPEN.LDC_BOPERSECUCION IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_BOPERSECUCION
  Descripcion    : PAQUETE PARA EL MANEJO DE PERSECUCION
  Autor          : Jorge Valiente
  Fecha          : 29/10/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  14/07/2023	  cgonzalez (Horbath) OSF-1326: Modificar los servicios PRANULA_ORDENES_PERSECUCION, 
										PRANULA_ORDEN_PERSECUCION y PRSUSPENSIONCMPERSECUCION.
  ******************************************************************/

  /*VACTOR PARA ALMACENAR LOS DATOS PROVENIENETES LINEA DE ARCHIVO*/
  TYPE TBARRAY IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_ANULAR_ORDEN
  Descripcion    : Metodo para anular ordenes de persecucion que aun estan registradas
                   y se genere orden de certificaion o por OIA
  Autor          : Jorge Valiente.
  Fecha          : 29/10/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/07/2023	  cgonzalez (Horbath) OSF-1326: Se utiliza el api api_anullorder para anular la orden
  ******************************************************************/
  PROCEDURE PRANULA_ORDEN_PERSECUCION(inuProduct_id pr_certificate.product_id%type);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRANULA_ORDENES_PERSECUCION
  Descripcion    : Metodo para anular TODAS las  ordenes de persecucion
                   que aun estan registradas
  Autor          : Jorge Valiente.
  Fecha          : 29/10/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  14/07/2023	  cgonzalez (Horbath) OSF-1326: Se modifica para procesar ordenes de tipo
										de trabajo configurado en el parametro TIPOS_TRABAJO_PERSECUCION
  ******************************************************************/
  PROCEDURE PRANULA_ORDENES_PERSECUCION;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRSUSPENSIONCMPERSECUCION
  Descripcion    : -Metodo para actualizar edstado del prodcuto y el
                    de sus componenetes
                   -registrar en PR_PROD_SUSPENSION y PR_COMP_SUSPENSION
                   -Si la legalizacion es con causal de exito se actualiza
                    el estado del corte del producto.
  Autor          : Jorge Valiente.
  Fecha          : 29/10/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/07/2023	  cgonzalez (Horbath) OSF-1326: Se elimina codigo en comentarios
  ******************************************************************/
  PROCEDURE PRSUSPENSIONCMPERSECUCION;

END LDC_BOPERSECUCION;
/

CREATE OR REPLACE PACKAGE BODY OPEN.LDC_BOPERSECUCION IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_BOPERSECUCION
  Descripcion    : PAQUETE PARA EL MANEJO DE PERSECUCION
  Autor          : Jorge Valiente
  Fecha          : 29/10/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  14/07/2023	  cgonzalez (Horbath) OSF-1326: Modificar los servicios PRANULA_ORDENES_PERSECUCION, 
										PRANULA_ORDEN_PERSECUCION y PRSUSPENSIONCMPERSECUCION.
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRANULA_ORDEN_PERSECUCION
  Descripcion    : Metodo para anular ordenes de persecucion que aun estan registradas
                   y se genere orden de certificaion o por OIA
  Autor          : Jorge Valiente.
  Fecha          : 29/10/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/07/2023	  cgonzalez (Horbath) OSF-1326: Se utiliza el api api_anullorder para anular la orden
  ******************************************************************/
  PROCEDURE PRANULA_ORDEN_PERSECUCION(inuProduct_id pr_certificate.product_id%type) IS

    nuOK        number := 0;
    nuVlrDeuda  NUMBER(15, 2) := 0;
	
	nuErrorCode     NUMBER;
    sbErrorMessage  VARCHAR2(2000);

    cursor cuOtPersecucion is
      select susp_persec_producto, susp_persec_fegeot, order_id, sesususc, sesucate
        from ldc_susp_persecucion, or_order, servsusc
       where order_status_id = 0
         and susp_persec_order_id = order_id
         and susp_persec_producto = inuProduct_id
		 and susp_persec_producto = sesunuse;

    cursor cuPago(inususc servsusc.sesususc%type,
                  dtfecha pagos.PAGOFEPA%type) IS
      select count(1)
        from pagos
       where PAGOSUSC = inususc
         and PAGOFEPA >= dtfecha;
  BEGIN
	UT_TRACE.TRACE('INICIO LDC_BOPERSECUCION.PRANULA_ORDEN_PERSECUCION', 3);

    for reg in cuOtPersecucion loop
	
	  UT_TRACE.TRACE('PRODUCTO: '||reg.susp_persec_producto, 5);
	  UT_TRACE.TRACE('ORDEN: '||reg.order_id, 5);	  
	  
	  IF (cuPago%ISOPEN) THEN
        CLOSE cuPago;
      END IF;
	  
      open cuPago(reg.sesususc, reg.susp_persec_fegeot);
      fetch cuPago
        into nuOk;
      close cuPago;
	  
      if (nuOk > 0) then
        if (reg.sesucate = 1) then
          nuVlrDeuda := gc_bodebtmanagement.fnugetexpirdebtbyprod(reg.susp_persec_producto); -- deuda vencida
        else
          nuVlrDeuda := gc_bodebtmanagement.fnugetdebtbyprod(reg.susp_persec_producto); -- Deuda Corriente (Vencida y No vencida)
        end if;
        if nuVlrDeuda = 0 then
          -- Anula la orden
          api_anullorder(reg.order_id, 1277, 'ANULACION DE ORDEN DE PERSECUCION', nuErrorCode, sbErrorMessage);
		  
		  UT_TRACE.TRACE('nuErrorCode: '||nuErrorCode, 5);
		  UT_TRACE.TRACE('sbErrorMessage: '||sbErrorMessage, 5);
		  
        end if;
      END IF;
    END LOOP;
	
	UT_TRACE.TRACE('FIN LDC_BOPERSECUCION.PRANULA_ORDEN_PERSECUCION', 3);

  EXCEPTION
    when OTHERS then
	  UT_TRACE.TRACE('ERROR OTHERS LDC_BOPERSECUCION.PRANULA_ORDENES_PERSECUCION', 3);
      Pkg_Error.SetError;
      Pkg_Error.GetError(nuErrorCode, sbErrorMessage);
	  RAISE Pkg_Error.CONTROLLED_ERROR;
  END PRANULA_ORDEN_PERSECUCION;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRANULA_ORDENES_PERSECUCION
  Descripcion    : Metodo para anular TODAS las  ordenes de persecucion
                   que aun estan registradas
  Autor          : Jorge Valiente.
  Fecha          : 29/10/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  14/07/2023	  cgonzalez (Horbath) OSF-1326: Se modifica para procesar ordenes de tipo
										de trabajo configurado en el parametro TIPOS_TRABAJO_PERSECUCION
  ******************************************************************/
  PROCEDURE PRANULA_ORDENES_PERSECUCION IS

    nuOK        number := 0;
    nuVlrDeuda  NUMBER(15, 2) := 0;
    
    sbTipoTrabajo   VARCHAR2(2000) := ldc_bcConsGenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','TIPOS_TRABAJO_PERSECUCION');
    nuErrorCode     NUMBER;
    sbErrorMessage  VARCHAR2(2000);

    CURSOR cuOtPersecucion IS
        SELECT  /*+ 
					use_nl(o, a, s)
					index(o idx_or_order_012)
					index(a idx_or_order_activity_05)
					index(s pk_servsusc)
				*/
				a.product_id susp_persec_producto, o.created_date susp_persec_fegeot,
                o.order_id order_id, s.sesususc sesususc, s.sesucate sesucate
        FROM    /*PRANULA_ORDENES_PERSECUCION.cuOtPersecucion*/
				or_order o, or_order_activity a, servsusc s
        WHERE   o.task_type_id IN (SELECT TO_NUMBER(regexp_substr(sbTipoTrabajo, '[^,]+', 1, LEVEL)) AS task_type_id
                                    FROM dual
                                    CONNECT BY regexp_substr(sbTipoTrabajo, '[^,]+', 1, LEVEL) IS NOT NULL)
        AND     o.order_status_id = 0
        AND     o.order_id = a.order_id
        AND     a.product_id = s.sesunuse;

    cursor cuPago(inususc servsusc.sesususc%type,
                  dtfecha pagos.PAGOFEPA%type) IS
      select count(1)
        from pagos
       where PAGOSUSC = inususc
         and PAGOFEPA >= dtfecha;
  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BOPERSECUCION.PRANULA_ORDENES_PERSECUCION', 3);
    
    FOR reg IN cuOtPersecucion LOOP
	  
	  UT_TRACE.TRACE('PRODUCTO: '||reg.susp_persec_producto, 5);
	  UT_TRACE.TRACE('ORDEN: '||reg.order_id, 5);
	  
	  IF (cuPago%ISOPEN) THEN
        CLOSE cuPago;
      END IF;
      
      OPEN cuPago(reg.sesususc, reg.susp_persec_fegeot);
      FETCH cuPago into nuOk;
      CLOSE cuPago;
      
	  IF (nuOk > 0) THEN
        IF (reg.sesucate = 1) THEN
          nuVlrDeuda := gc_bodebtmanagement.fnugetexpirdebtbyprod(reg.susp_persec_producto); -- deuda vencida
        ELSE
          nuVlrDeuda := gc_bodebtmanagement.fnugetdebtbyprod(reg.susp_persec_producto); -- Deuda Corriente (Vencida y No vencida)
        END IF;
        
        IF (nuVlrDeuda = 0) THEN
          -- Anula la orden
          api_anullorder(reg.order_id, 1277, 'ORDEN ANULADA MEDIANTE JOB DE ANULACION DE ORDENES DE PERSECUCION', nuErrorCode, sbErrorMessage);
		  
		  UT_TRACE.TRACE('nuErrorCode: '||nuErrorCode, 5);
		  UT_TRACE.TRACE('sbErrorMessage: '||sbErrorMessage, 5);
		  
        END IF;
      END IF;
    END LOOP;
    
    UT_TRACE.TRACE('FIN LDC_BOPERSECUCION.PRANULA_ORDENES_PERSECUCION', 3);

  EXCEPTION
    when OTHERS then
      UT_TRACE.TRACE('ERROR OTHERS LDC_BOPERSECUCION.PRANULA_ORDENES_PERSECUCION', 3);
      Pkg_Error.SetError;
      Pkg_Error.GetError(nuErrorCode, sbErrorMessage);
	  RAISE Pkg_Error.CONTROLLED_ERROR;
  END PRANULA_ORDENES_PERSECUCION;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRSUSPENSIONCMPERSECUCION
  Descripcion    : -Metodo para actualizar edstado del prodcuto y el
                    de sus componenetes
                   -registrar en PR_PROD_SUSPENSION y PR_COMP_SUSPENSION
                   -Si la legalizacion es con causal de exito se actualiza
                    el estado del corte del producto.
  Autor          : Jorge Valiente.
  Fecha          : 29/10/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/07/2023	  cgonzalez (Horbath) OSF-1326: Se elimina codigo en comentarios
  ******************************************************************/
  PROCEDURE PRSUSPENSIONCMPERSECUCION IS

    cursor cuorderactivity(nuorder_id or_order.order_id%type) is
      SELECT OOA.*
        FROM OPEN.OR_ORDER_ACTIVITY OOA
       WHERE OOA.Order_Id = nuorder_id;

    rccuorderactivity cuorderactivity%rowtype;

    cursor cupr_component(NUPRODUCT_ID PR_PRODUCT.PRODUCT_ID%type) is
      SELECT PC.* FROM pr_component pc where pc.product_id = NUPRODUCT_ID;

    nuordenlegalizada or_order.order_id%type; --orden que se esta legalizando
    nucausal_id       or_order.causal_id%type;
    EX_ERROR exception; --control de exepciones
    SBMENSAJE                      varchar2(4000);
    NUESTADO_PRODCUTO_SUSPENDIDO   LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_PRODCUTO_SUSPENDIDO',
                                                                                                         NULL);
    NUESTADO_COMPONENTE_SUSPENDIDO LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_COMPONENTE_SUSPENDIDO',
                                                                                                         NULL);
    NUTIPO_SUSPENSION_PRODUCTO     LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('TIPO_SUSPENSION_PRODUCTO',
                                                                                                         NULL);
    NUTIPO_SUSPENSION_COMPONENTE   LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('TIPO_SUSPENSION_COMPONENTE',
                                                                                                         NULL);
    NULDC_CAUSAL_EXITO             LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('LDC_CAUSAL_EXITO',
                                                                                                         NULL);
    NUESTA_CORT_PROD_CONEXION      LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('ESTA_CORT_PROD_CONEXION',
                                                                                                         NULL);
    NUESTA_CORT_PROD_SUSP_PARC     LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('ESTA_CORT_PROD_SUSP_PARC',
                                                                                                         NULL);
  BEGIN

    UT_TRACE.TRACE('INICIA LDC_BOPERSECUCION.PRSUSPENSIONCMPERSECUCION',
                   10);

    IF NUESTADO_PRODCUTO_SUSPENDIDO IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO ESTADO_PRODCUTO_SUSPENDIDO ES NULO';
      RAISE EX_ERROR;
    END IF;

    IF NUESTADO_COMPONENTE_SUSPENDIDO IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO ESTADO_COMPONENTE_SUSPENDIDO ES NULO';
      RAISE EX_ERROR;
    END IF;

    IF NUTIPO_SUSPENSION_PRODUCTO IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO TIPO_SUSPENSION_PRODUCTO ES NULO';
      RAISE EX_ERROR;
    END IF;

    IF NUTIPO_SUSPENSION_COMPONENTE IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO TIPO_SUSPENSION_COMPONENTE ES NULO';
      RAISE EX_ERROR;
    END IF;

    IF NULDC_CAUSAL_EXITO IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO LDC_CAUSAL_EXITO ES NULO';
      RAISE EX_ERROR;
    END IF;

    IF NUESTA_CORT_PROD_CONEXION IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO ESTA_CORT_PROD_CONEXION ES NULO';
      RAISE EX_ERROR;
    END IF;

    IF NUESTA_CORT_PROD_SUSP_PARC IS NULL THEN
      SBMENSAJE := 'EL PARAMETRO ESTA_CORT_PROD_SUSP_PARC ES NULO';
      RAISE EX_ERROR;
    END IF;

    nuordenlegalizada := or_bolegalizeorder.fnugetcurrentorder;

    IF NULDC_CAUSAL_EXITO =
       DAGE_CLASS_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(daor_order.fnugetcausal_id(nuordenlegalizada,
                                                                                                            null),
                                                                                 NULL),
                                               NULL) THEN
      open cuorderactivity(nuordenlegalizada);
      fetch cuorderactivity
        into rccuorderactivity;
      if cuorderactivity%found then

        --prodcuto
        --actualizar estado del producto
        update pr_product p
           set p.product_status_id = NUESTADO_PRODCUTO_SUSPENDIDO
         where p.product_id = rccuorderactivity.product_id;

        insert into pr_prod_suspension
          (prod_suspension_id,
           product_id,
           suspension_type_id,
           register_date,
           aplication_date,
           inactive_date,
           active,
           connection_code)
        values
          (SEQ_PR_PROD_SUSPENSION.NEXTVAL,
           rccuorderactivity.product_id,
           NUTIPO_SUSPENSION_PRODUCTO,
           SYSDATE,
           SYSDATE,
           NULL,
           'Y',
           NULL);
        --fin prodcuto

        --componentes del prdcuto
        --actualizar estado de componentes
        update pr_component pc
           set pc.component_status_id = NUESTADO_COMPONENTE_SUSPENDIDO
         where pc.product_id = rccuorderactivity.product_id;

        FOR RCcupr_component IN cupr_component(rccuorderactivity.product_id) LOOP
          insert into pr_comp_suspension
            (comp_suspension_id,
             component_id,
             suspension_type_id,
             register_date,
             aplication_date,
             inactive_date,
             active)
          values
            (SEQ_PR_COMP_SUSPENSION.NEXTVAL,
             RCcupr_component.Component_Id,
             NUTIPO_SUSPENSION_COMPONENTE,
             SYSDATE,
             SYSDATE,
             NULL,
             'Y');
        END LOOP;
        --fin componente del prodcuto
        
      else
        SBMENSAJE := 'la orden [' || nuordenlegalizada ||
                     '] - no tiene regiistro en OR_ORDER_ACTIVITY';
        RAISE EX_ERROR;
      end if;
      close cuorderactivity;
    END IF;

    UT_TRACE.TRACE('INICIA LDC_BOPERSECUCION.PRSUSPENSIONCMPERSECUCION',
                   10);

  exception
    WHEN EX_ERROR THEN
	  Pkg_Error.SetErrorMessage(LD_BOCONSTANS.CNUGENERIC_ERROR, SBMENSAJE);
      RAISE;

  END PRSUSPENSIONCMPERSECUCION;

END LDC_BOPERSECUCION;
/