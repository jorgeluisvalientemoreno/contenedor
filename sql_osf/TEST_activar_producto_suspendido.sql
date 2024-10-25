declare

  --oal_activaproductosuspendido
  --pkg_gestion_producto.prcActivaProductoSuspendido

  inuOrden          number;
  inuOrdenActividad number;
  inuContrato       number;
  inuProducto       number := 6550425;

  -- Nombre de este metodo
  csbMetodo   VARCHAR2(70) := 'prcActivaProductoSuspendido';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error

  --Tipo de suspension
  cnuTipSus_FaltaPago CONSTANT number := 2; --Cartera

  --Estado Activo del producto definido en la entidad PS_PRODUCT_STATUS
  CNUESTADO_ACTIVO_PRODUCTO PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 1;

  --Estado Activo del componente definido en la entidad PS_PRODUCT_STATUS
  CNUESTADO_ACTIVO_COMPONENTE PR_COMPONENT.COMPONENT_STATUS_ID%TYPE := 5;

  -- Estado conexion del servicio suscrito definido en la entidad estacort
  CNUESTADO_CONEXION_SERVSUSC SERVSUSC.SESUESCO%TYPE := 1;

  sbActualiza varchar2(1) := 'N';

  CURSOR cuComponentes IS
    SELECT COMP_SUSPENSION_ID
      FROM PR_COMPONENT C, PR_COMP_SUSPENSION CS
     WHERE PRODUCT_ID = inuProducto
       AND C.COMPONENT_ID = CS.COMPONENT_ID
       AND ACTIVE = 'Y';

  cursor cuTipoSuspension is
    select pps.suspension_type_id
      from PR_PROD_SUSPENSION pps
     WHERE pps.PRODUCT_ID = inuProducto
       AND pps.suspension_type_id = cnuTipSus_FaltaPago
       AND pps.ACTIVE = 'Y';

  nuTipoSuspension number;

  rcSuspCone SUSPCONE%ROWTYPE;

  cursor cuExiste(inuValorData number, isbValorParamerto varchar2) is
    select count(1)
      from dual
     where inuValorData in
           (SELECT to_number(regexp_substr(isbValorParamerto,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS Valor
              FROM dual
            CONNECT BY regexp_substr(isbValorParamerto, '[^,]+', 1, LEVEL) IS NOT NULL);

  nuExisteEstadoServicio number := 0;
  sbEstadoCorteServicio  varchar2(4000);

  nuEstadoProducto number;

  cursor cuData is
    select --ooa.order_activity_id OrdenActividad,
     s.sesunuse Servicio,
     s.sesususc Contrato,
     s.sesuserv TipoServicio,
     s.sesuesco EstadoCorteServicio,
     sys_context('USERENV', 'TERMINAL') Terminal,
     sys_context('USERENV', 'SESSION_USER') Usuario,
     pp.product_status_id EstadoProducto,
     s.sesucicl ciclo
    --,oo.execution_final_date FechaFinalEjecucion
      from servsusc s, pr_product pp --, Or_Order_Activity ooa, or_order oo
     where --oo.order_id = inuOrden
    --and oo.order_id = ooa.order_id
    --and 
     s.sesunuse = inuProducto --ooa.product_id
     and s.sesunuse = pp.product_id
    --and ooa.final_date is null
    --and ooa.task_type_id = oo.task_type_id
    ;

  rfData cuData%rowtype;

  nuTipoServicio        number;
  nuEstadoCorteServicio number;
  nuEstadoProductoOrden number;
  nuCiclo               number;
  dtFechaFinalEjecucion date;
  sbTerminal            varchar2(4000);
  sbUsuario             varchar2(4000);

BEGIN

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  --Parametro Estado de producto 
  nuEstadoProducto := pkg_parametros.fnuGetValorNumerico('EST_ACTI_PROD_SUSP');
  pkg_traza.trace('Valor EST_ACTI_PROD_SUSP: ' || nuEstadoProducto,
                  pkg_traza.cnuNivelTrzDef);
  ------------------------------------------

  open cuData;
  fetch cuData
    into rfData;
  close cuData;

  nuEstadoProductoOrden := rfData.Estadoproducto;
  nuTipoServicio        := rfData.Tiposervicio;
  nuEstadoCorteServicio := rfData.Estadocorteservicio;
  nuCiclo               := rfData.Ciclo;
  --dtFechaFinalEjecucion := rfData.Fechafinalejecucion;
  sbTerminal := rfData.Terminal;
  sbUsuario  := rfData.Usuario;

  pkg_traza.trace('Orden: ' || inuOrden);
  pkg_traza.trace('Orden Actividad: ' || inuOrdenActividad);
  pkg_traza.trace('Contrato: ' || inuContrato, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Producto: ' || inuProducto, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Estado Producto: ' || nuEstadoProductoOrden,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Tipo Servicio: ' || nuTipoServicio,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Estado de Corte servicio: ' || nuEstadoCorteServicio,
                  pkg_traza.cnuNivelTrzDef);

  pkg_traza.trace('Ciclo: ' || nuCiclo, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Codgo Actividad Orden: ' || inuOrdenActividad,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Fecha Final Ejecucion: ' || dtFechaFinalEjecucion,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Terminal: ' || sbTerminal, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Cosigo Usuario: ' || sbUsuario,
                  pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace('Existe Estado Corte Servicio en parametro ESTA_CORT_ACTI_SERV_SUSP: ' ||
                  nuExisteEstadoServicio,
                  pkg_traza.cnuNivelTrzDef);

  --Valida si es el estado del producto es igual al del parametro EST_ACTI_PROD_SUSP
  pkg_traza.trace('Validacion if nuEstadoProductoOrden[' ||
                  nuEstadoProductoOrden || '] = nuEstadoProducto[' ||
                  nuEstadoProducto || '] then',
                  pkg_traza.cnuNivelTrzDef);

  if nuEstadoProductoOrden = nuEstadoProducto then
  
    ---Obtiene tipo de suspension del prodcuto
    open cuTipoSuspension;
    fetch cuTipoSuspension
      into nuTipoSuspension;
    close cuTipoSuspension;
    pkg_traza.trace('Tipo Suspension: ' || nuTipoSuspension,
                    pkg_traza.cnuNivelTrzDef);
    ----------------------------------------------------------
  
    --Tipo de suspension cartera
    pkg_traza.trace('if nuTipoSuspension[' || nuTipoSuspension ||
                    '] = cnuTipSus_FaltaPago[' || cnuTipSus_FaltaPago ||
                    '] then',
                    pkg_traza.cnuNivelTrzDef);
    if nuTipoSuspension = cnuTipSus_FaltaPago then
    
      --Validar estado de corte de servicio  
      sbEstadoCorteServicio := pkg_bcld_parameter.fsbObtieneValorCadena('ESTA_CORT_ACTI_SERV_SUSP');
      pkg_traza.trace('Valor ESTA_CORT_ACTI_SERV_SUSP: ' ||
                      sbEstadoCorteServicio,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Estado Corte Servicio: ' || nuEstadoCorteServicio,
                      pkg_traza.cnuNivelTrzDef);
      open cuExiste(nuEstadoCorteServicio, sbEstadoCorteServicio);
      fetch cuExiste
        into nuExisteEstadoServicio;
      close cuExiste;
      ------------------------------------------
    
      if nuExisteEstadoServicio > 0 and sbActualiza = 'S' then
      
        --Actualiza estado de corte de servicio 
        pkg_producto.prActualizaEstadoCorte(inuProducto,
                                            CNUESTADO_CONEXION_SERVSUSC);
      
        --Registra DATA en SUSPCONE
        rcSuspCone.SUCODEPA       := -1; --departamento 
        rcSuspCone.SUCOLOCA       := -1; --localidad 
        rcSuspCone.SUCONUOR       := inuOrden; -- Numero de la ORden
        rcSuspCone.SUCOSUSC       := inuContrato; -- Contrato
        rcSuspCone.SUCOSERV       := nuTipoServicio; -- Servicio
        rcSuspCone.SUCONUSE       := inuProducto; -- Producto
        rcSuspCone.SUCOTIPO       := 'C'; -- Tipo de Suspencion
        rcSuspCone.SUCOFEOR       := sysdate; -- Fecha creacion de la Orden
        rcSuspCone.SUCOFEAT       := sysdate; -- Fecha de Fin de ejecucion 
        rcSuspCone.SUCOCACD       := 2; --
        rcSuspCone.SUCOOBSE       := 'PRCACTIVAPRODUCTOSUSPENDIDO'; --
        rcSuspCone.SUCOCOEC       := nuEstadoCorteServicio; -- Estado de corte que genero la Or
        rcSuspCone.CAUSE_FAILURE  := Null; --causa del fallo 
        rcSuspCone.PROCESS_STATUS := NULL; --estado del proceso 
        rcSuspCone.SUCOCICL       := nuCiclo; --ciclo para el que se genero la orden 
        rcSuspCone.SUCOCENT       := Null; --central para la que se genero la orden 
        rcSuspCone.SUCOPROG       := 'FPCA'; --programa con el que se genero la orden 
        rcSuspCone.SUCOTERM       := sbTerminal; --terminal con la que se genero la orden 
        rcSuspCone.SUCOUSUA       := sbUsuario; --usuario que genero la orden 
        rcSuspCone.SUCOORIM       := 'N'; --orden impresa ? 
        rcSuspCone.SUCOACTIV_ID   := inuOrdenActividad; --codigo actividad de orden que legaliza
        rcSuspCone.SUCOORDTYPE    := 3; --tipo de orden en bss
        rcSuspCone.SUCOACGC       := Null; --actividad gestion de cobro 
        rcSuspCone.SUCOCUPO       := null; --numero del cupon de pago
      
        pkg_suspcone.prcInsertaRegistro(rcSuspCone);
      
      else
        pkg_error.setErrorMessage(isbMsgErrr => 'El servicio [' ||
                                                inuProducto ||
                                                '] estan suspendido por cartera.');
      end if; --if nuExisteEstadoServicio > 0 then
    
    end if; --if nuTipoSuspension = 2 then
  
    --Actualiza Estado de Producto Suspendido 
    if sbActualiza = 'S' then
      pkg_producto.prActualizaEstadoProducto(inuProducto,
                                             CNUESTADO_ACTIVO_PRODUCTO);
      pkg_producto.prcActualizaUltActSuspension(inuProducto, null);
    
      --Inactiva la suspension del Producto
      pkg_pr_prod_suspension.prcInactivaSuspension(inuProducto,
                                                   dtFechaFinalEjecucion);
    
      --Actualiza estado de componente de Producto suspendido      
      pkg_componente_producto.prActualizaEstadocomponente(inuProducto,
                                                          CNUESTADO_ACTIVO_COMPONENTE);
    
      --Inactiva la suspension del componente de suspension del de Producto
      FOR RC IN cuComponentes LOOP
        pkg_pr_comp_suspension.prcInactivaSuspension(RC.COMP_SUSPENSION_ID,
                                                     dtFechaFinalEjecucion);
      END LOOP;
    
      --Cancela la inclusion del producto
      pkg_inclusion_cartera.prcCancelaInclucion(inuProducto);
    end if;
  
  end if; --if inuEstadoProdcuto = nuEstadoProducto then

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

end;
