column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  --Estado Activo del producto definido en la entidad PS_PRODUCT_STATUS
  CNUESTADO_ACTIVO_PRODUCTO PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 1;
  --Estado Activo del componente definido en la entidad PS_PRODUCT_STATUS
  CNUESTADO_ACTIVO_COMPONENTE PR_COMPONENT.COMPONENT_STATUS_ID%TYPE := 5;
  -- Estado conexion del servicio suscrito definido en la entidad estacort
  CNUESTADO_CONEXION_SERVSUSC SERVSUSC.SESUESCO%TYPE := 1;
  --Tipo Suspension Cartera
  cnuTipSus_FaltaPago CONSTANT number := 2;

  csbMETODO CONSTANT VARCHAR2(100) := 'OSF-3950';

  -- Nombre de este metodo
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error

  CURSOR cuComponentes 
  (
    inuProducto IN pr_product.product_id%TYPE
  )
  IS
    SELECT COMP_SUSPENSION_ID
      FROM PR_COMPONENT C, PR_COMP_SUSPENSION CS
     WHERE PRODUCT_ID = inuProducto
       AND C.COMPONENT_ID = CS.COMPONENT_ID
       AND ACTIVE = 'Y';

  cursor cuTipoSuspension 
  (
    inuProducto IN pr_product.product_id%TYPE
  )
  is
    select pps.suspension_type_id
      from PR_PROD_SUSPENSION pps
     WHERE pps.PRODUCT_ID = inuProducto
       AND pps.ACTIVE = 'Y';

  nuTipoSuspension number;

  rcSuspCone SUSPCONE%ROWTYPE;

  nuExisteEstadoServicio number := 0;
  sbEstadoCorteServicio  varchar2(4000);

  nuEstadoProducto number;

  cursor cuData 
  (
    inuProducto IN pr_product.product_id%TYPE
  )
  is
    select s.sesunuse           Servicio,
           s.sesususc           Contrato,
           s.sesuserv           TipoServicio,
           s.sesuesco           EstadoCorteServicio,
           pp.product_status_id EstadoProducto,
           s.sesucicl           ciclo
      from servsusc s, pr_product pp
     where s.sesunuse = pp.product_id
       and s.sesunuse = inuProducto;


  CURSOR cuOrdenes
  IS
  SELECT o.order_id, o.order_status_id, a.product_id, a.package_id
  FROM open.or_order o
  INNER JOIN open.or_order_activity a ON o.order_id=a.order_id 
  WHERE o.order_id in (353082589,353082896) AND o.order_status_id in (8);


  rfData cuData%rowtype;

  nuTipoServicio        number;
  nuEstadoCorteServicio number;
  nuEstadoProductoOrden number;
  nuCiclo               number;
  dtFechaFinalEjecucion date := sysdate;
  sbTerminal            varchar2(4000);
  sbUsuario             varchar2(4000);

  nuError           number;
  sbError           varchar2(4000);  
BEGIN

  dbms_output.put_line('Inicio ' || csbMetodo);

  --Parametro Estado de producto 
  nuEstadoProducto := pkg_parametros.fnuGetValorNumerico('EST_ACTI_PROD_SUSP');
  dbms_output.put_line('Parametro Estado de producto en EST_ACTI_PROD_SUSP: ' ||
                       nuEstadoProducto);
  ------------------------------------------

  dbms_output.put_line('ORDEN|RESULTADO');
  FOR reg in cuOrdenes LOOP
      BEGIN
        sbError := null;

        OPEN cuData(reg.product_id);
        FETCH cuData INTO rfData;
        CLOSE cuData;

        nuEstadoProductoOrden := rfData.Estadoproducto;
        nuTipoServicio        := rfData.Tiposervicio;
        nuEstadoCorteServicio := rfData.Estadocorteservicio;
        nuCiclo               := rfData.Ciclo;

        dbms_output.put_line('Producto: ' || reg.product_id);
        dbms_output.put_line('Estado Producto: ' || nuEstadoProductoOrden);
        dbms_output.put_line('Tipo Servicio: ' || nuTipoServicio);
        dbms_output.put_line('Estado de Corte servicio: ' ||
                            nuEstadoCorteServicio);

        --Valida si es el estado del producto es igual al del parametro EST_ACTI_PROD_SUSP
        IF nuEstadoProductoOrden = nuEstadoProducto THEN
        
          ---Obtiene tipo de suspension del prodcuto
          OPEN cuTipoSuspension (reg.product_id);
          FETCH cuTipoSuspension INTO nuTipoSuspension;
          CLOSE cuTipoSuspension;

          dbms_output.put_line('Tipo Suspension: ' || nuTipoSuspension);
          ----------------------------------------------------------
      
          dbms_output.put_line('------Activa Producto Suspendido-----------------------------------------------------');
          --Actualiza Estado de Producto Suspendido      
          pkg_producto.prActualizaEstadoProducto(reg.product_id,
                                                CNUESTADO_ACTIVO_PRODUCTO);
          pkg_producto.prcActualizaUltActSuspension(reg.product_id, null);
          dbms_output.put_line('Actualiza Estado de Producto Suspendido a Estado Activo');
        
          --Inactiva la suspension del Producto
          pkg_pr_prod_suspension.prcInactivaSuspension(reg.product_id,
                                                      dtFechaFinalEjecucion);
          dbms_output.put_line('Inactiva la suspension del Producto');
        
          --Actualiza estado de componente de Producto suspendido      
          pkg_componente_producto.prActualizaEstadocomponente(reg.product_id,
                                                              CNUESTADO_ACTIVO_COMPONENTE);
          dbms_output.put_line('Actualiza estado de componente del Producto suspendido a Estado Activo');
        
          --Inactiva la suspension del componente de suspension del de Producto
          FOR RC IN cuComponentes(reg.product_id) LOOP
            pkg_pr_comp_suspension.prcInactivaSuspension(RC.COMP_SUSPENSION_ID,
                                                        dtFechaFinalEjecucion);
          END LOOP;
          dbms_output.put_line('Inactiva la suspension del componente de suspension del Producto');
        
          dbms_output.put_line('-----------------------------------------------------------');
          
        END IF; --if inuEstadoProdcuto = nuEstadoProducto then
        COMMIT;
        dbms_output.put_line(reg.order_id||'|OK');
    EXCEPTION
      WHEN others THEN
        pkg_error.setError;
        pkg_error.getError(nuError, sbError);
        ROLLBACK;    
        dbms_output.put_line(reg.order_id||'|'||sbError);
    END;
  END LOOP;

  dbms_output.put_line('Fin ' || csbMetodo);

EXCEPTION

  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    dbms_output.put_line('Error: ' || sbMensError);
    dbms_output.put_line(csbMetodo);
    Rollback;
    RAISE pkg_Error.Controlled_Error;
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/