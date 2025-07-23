CREATE OR REPLACE package PERSONALIZACIONES.PKG_GESTION_PRODUCTO IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_GESTION_PRODUCTO
    Descripcion     : Paquete para contener servicio realcioandos a la entidad PR_PRODUCT y sus componentes
    Autor           : Jorge Valiente
    Fecha           : 23-06-2023

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    jerazomvm   07/09/2023  OSF-1530    1. Se crea la constante CNUESTADO_CONEXION_SERVSUSC
                                        2. Se modifica el procedimiento PRACTIVAPRODUCTO

    Jsoto       09/11/2023  OSF-1911    Se crean las constantes de estados de producto
                                        Se cambia ut_trace por pkg_traza

    Jsoto       15/01/2024  OSF-2175    Se agregan constantes para estados de componente
    jerazomvm   29/02/2024  OSF-2374    1. Se crea el procedimiento prcReversaEstadoProducto
    jpinedc     27/01/2025  OSF-3893    Se crea prRetiraProductoSinInstal
    fvalencia   13/02/2025  OSF-3984    Se modifica el procedimiento prcActuaCateySubcaPorContrato
	jerazomvm 	03/01/2025  OSF-3812  	Se modifica el procedimiento prcActuaCateySubcaPorContrato
    LJLB        08/04/2025  OSF-4207    se agregan constante para metodos de variacion de consumo
	jerazomvm 	16/05/2025  OSF-4478  	Se modifica el procedimiento prcActuaCateySubcaPorContrato
  ***************************************************************************/

  --Estado Activo del producto definido en la entidad PS_PRODUCT_STATUS
  CNUESTADO_ACTIVO_PRODUCTO CONSTANT PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 1;

  --Estado Activo del componente definido en la entidad PS_PRODUCT_STATUS
  CNUESTADO_ACTIVO_COMPONENTE CONSTANT PR_COMPONENT.COMPONENT_STATUS_ID%TYPE := 5;

  -- Estado conexion del servicio suscrito definido en la entidad estacort
  CNUESTADO_CONEXION_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 1;

  -- OSF-1911
  -- Estados de Producto
  CNUESTADO_SUSPENDIDO_PRODUCTO  CONSTANT PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 2;
  CNUESTADO_RETIRADO_PRODUCTO    CONSTANT PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 3;
  CNUESTADO_PEND_INST_PRODUCTO   CONSTANT PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 15;
  CNUESTADO_RET_SIN_INS_PRODUCTO CONSTANT PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 16;
  CNUESTADO_PEND_RETIRO_PRODUCTO CONSTANT PR_PRODUCT.PRODUCT_STATUS_ID%TYPE := 20;

  --OSF-2175
  --Estados de Componente
  cnuEST_ACTIVO_COMPONENTE       CONSTANT pr_component.component_status_id%TYPE := 5;
  cnuEST_SUSPEND_COMPONENTE      CONSTANT pr_component.component_status_id%TYPE := 8;
  cnuEST_RETIRADO_COMPONENTE     CONSTANT pr_component.component_status_id%TYPE := 9;
  cnuEST_PEND_INSTAL_COMPONENTE  CONSTANT pr_component.component_status_id%TYPE := 17;
  cnuEST_RET_SIN_INST_COMPONENTE CONSTANT pr_component.component_status_id%TYPE := 18;
  cnuEST_PEND_RETIRO_COMPONENTE  CONSTANT pr_component.component_status_id%TYPE := 21;

  --Estados de corte
  CNUESTADO_ORD_SUS_PAR_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 2;
  CNUESTADO_SUSP_PARC_SERVSUSC   CONSTANT SERVSUSC.SESUESCO%TYPE := 3;
  CNUESTADO_SUSP_TOTAL_SERVSUSC  CONSTANT SERVSUSC.SESUESCO%TYPE := 5;
  CNUESTADO_ORDEN_CONEX_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 6;
  CNUESTADO_RETIRO_DEF_SERVSUSC  CONSTANT SERVSUSC.SESUESCO%TYPE := 92;
  CNUESTADO_INI_RET_VOL_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 94;
  CNUESTADO_RETIRO_VOL_SERVSUSC  CONSTANT SERVSUSC.SESUESCO%TYPE := 95;
  CNUESTADO_PEND_INSTAL_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 96;
  CNUESTADO_CONVEN_PAGO_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 99;
  CNUESTADO_RET_SIN_INS_SERVSUSC CONSTANT SERVSUSC.SESUESCO%TYPE := 110;

  --OSF-2477
  --Tipo de suspension
  cnuTipSus_FaltaPago CONSTANT number := 2; --Cartera

  --metodos de variacion de consumo
  cnuMetAnalisisConsumoGas            CONSTANT NUMBER := 1;
  cnuMetAnalisisConsumoTele     CONSTANT NUMBER := 2;
  cnuMetAnalisisConPrSinMedi    CONSTANT NUMBER := 3;
  cnuMetAnalisisConIndustrial     CONSTANT NUMBER := 4;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTIVAPRODUCTO
    Descripcion     : proceso que actualiza estado del producto
    Autor           : Jorge Valiente
    Fecha           : 23-06-2023

    Parametros de Entrada
      inuproduct_id     Identificador del producto
      idtsesufein   Fecha de instalación
    isbupdEstacort  Flag que indica si actualiza el estado de corte del producto (S/N).

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 07/09/2023  OSF-1530  Se adiciona el parametro de entrada isbupdEstacort
  ***************************************************************************/
  PROCEDURE PRACTIVAPRODUCTO(inuproduct_id  IN pr_product.product_id%TYPE,
                             idtsesufein    IN servsusc.sesufein%TYPE,
                             isbupdEstacort IN VARCHAR2);

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReversaEstadoProducto
    Descripcion     : proceso que rversa el estado del producto asociado a la solicitud
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024

    Parametros de Entrada
      inuSolicitudId  identificador de la solicitud

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 29/02/2024  OSF-2374  Creación
  ***************************************************************************/
    PROCEDURE prcReversaEstadoProducto(inuSolicitudId in mo_packages.package_id%type);

    --proceso que activa producto suspendido
    PROCEDURE prcActivaProductoSuspendido(inuOrden          number,
                                        inuOrdenActividad number,
                                        inuContrato       number,
                                        inuProducto       number);

    PROCEDURE prcActuaCateySubcaPorContrato
    (
    inucontrato       IN servsusc.sesususc%TYPE,
    inuCategoria      IN servsusc.sesucate%TYPE,
    inuSubCategoria   IN servsusc.sesusuca%TYPE
    );

    -- Retira un producto y sus componentes
    PROCEDURE prRetiraProductoSinInstal
    (
        inuProducto IN   pr_product.product_id%TYPE
    );

END PKG_GESTION_PRODUCTO;
/
CREATE OR REPLACE package body PERSONALIZACIONES.PKG_GESTION_PRODUCTO IS

    csbNOMPKG CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    cnuNVLTRC CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
    csbInicio CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    csbVersion CONSTANT VARCHAR2(35) :='OSF-4489';

   FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 08/04/2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
   LJLB        08/04/2025  OSF-4207    Creacion
   ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PRACTIVAPRODUCTO
    Descripcion     : proceso que actualiza estado del producto
    Autor           : Jorge Valiente
    Fecha           : 23-06-2023

    Parametros de Entrada
      inuproduct_id     Identificador del producto
      idtsesufein   Fecha de instalación
    isbupdEstacort  Flag que indica si actualiza el estado de corte del producto (S/N)

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 07/09/2023  OSF-1530  Se adiciona el parametro de entrada isbupdEstacort
  dsaltarin 15/09/2023  OSF-1530  Se actualiza la fecha de instalación de componentes
  Jsoto   09/11/2023  OSF-1911  Se actualiza el manejo de traza por personalizada
  ***************************************************************************/
  PROCEDURE PRACTIVAPRODUCTO(inuproduct_id  IN pr_product.product_id%TYPE,
                             idtsesufein    IN servsusc.sesufein%TYPE,
                             isbupdEstacort IN VARCHAR2) IS

    csbMETODO CONSTANT VARCHAR2(100) := csbNOMPKG || 'PRACTIVAPRODUCTO';
    nuCodError NUMBER;
    sbMenError VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMetodo, cnuNVLTRC, csbInicio);

    pkg_traza.trace('inuproduct_id: ' || inuproduct_id, cnuNVLTRC);
    pkg_traza.trace('idtsesufein: ' || idtsesufein, cnuNVLTRC);
    pkg_traza.trace('isbupdEstacort: ' || isbupdEstacort, cnuNVLTRC);

    --Actualiza fecha de instalacion del servicio
    PKG_PRODUCTO.PRACTUALIZAFECHAINSTALACION(inuproduct_id, idtsesufein);

    --Actualiza estado de producto
    pkg_traza.trace('Actualiza estado [' || CNUESTADO_ACTIVO_PRODUCTO ||
                    '] al producto [' || inuproduct_id || ']',
                    cnuNVLTRC);
    PKG_PRODUCTO.PRACTUALIZAESTADOPRODUCTO(inuproduct_id,
                                           CNUESTADO_ACTIVO_PRODUCTO);

    --Actualiza estado de componentes del producto
    pkg_traza.trace('Actualiza estado [' || CNUESTADO_ACTIVO_COMPONENTE ||
                    '] a los componentes del producto [' || inuproduct_id || ']',
                    cnuNVLTRC);
    pkg_Componente_Producto.PRACTUALIZAESTADOCOMPONENTE(inuproduct_id,
                                                        CNUESTADO_ACTIVO_COMPONENTE);

    --Actualiza fecha de de instalación de componentes
    pkg_Componente_Producto.PRACTUALIZAFECHAINSTALACION(inuproduct_id,
                                                        idtsesufein);
    -- Valida el flag de actualizar el estado de corte
    pkg_traza.trace('El flag de actualizar el estado de corte del producto es [' ||
                    isbupdEstacort || ']',
                    cnuNVLTRC);
    IF (isbupdEstacort = 'S') THEN
      PKG_PRODUCTO.PRACTUALIZAESTADOCORTE(inuproduct_id,
                                          CNUESTADO_CONEXION_SERVSUSC);
    END IF;

    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      pkg_error.GetError(nuCodError, sbMenError);
      pkg_traza.trace(csbMetodo || ' ' || 'Error:' || nuCodError || '-' ||
                      sbMenError);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
      Pkg_Error.seterror;
      pkg_error.GetError(nuCodError, sbMenError);
      pkg_traza.trace(csbMetodo || ' ' || 'Error:' || nuCodError || '-' ||
                      sbMenError);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      raise PKG_ERROR.CONTROLLED_ERROR;
  END PRACTIVAPRODUCTO;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcReversaEstadoProducto
    Descripcion     : proceso que rversa el estado del producto asociado a la solicitud
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024

    Parametros de Entrada
      inuSolicitudId  identificador de la solicitud

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
  jerazomvm 29/02/2024  OSF-2374  Creación
  ***************************************************************************/
  PROCEDURE prcReversaEstadoProducto(inuSolicitudId in mo_packages.package_id%type) IS

    csbMETODO CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                        'prcReversaEstadoProducto';
    nuError          NUMBER;
    nuMotiveId       mo_motive.motive_id%type;
    nuValorAnteCompo NUMBER;
    nuValorAnteProd  NUMBER;
    sbmensaje        VARCHAR2(1000);
    sbProducIdx      VARCHAR2(50);
    sbComponIdx      VARCHAR2(50);
    tbProductosId    pkg_bcproducto.tytbproduct_id;
    tbprComponenteId pkg_bccomponentes.tytbcomponent_id;

  BEGIN

    pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);

    pkg_traza.trace('inuSolicitudId: ' || inuSolicitudId, cnuNVLTRC);

    PKG_ERROR.SETAPPLICATION('CUSTOMER');

    -- Obtiene los productos asociados a la solicitud
    pkg_bcgestion_solicitudes.prcObtienProductxSolicitud(inuSolicitudId,
                                                         tbProductosId);

    sbProducIdx := tbProductosId.first;

    WHILE sbProducIdx IS NOT NULL LOOP
      -- Obtiene el motivo asociado al producto y solicitud
      nuMotiveId := pkg_bcgestion_solicitudes.fnuMotivoxSoliciyProd(inuSolicitudId,
                                                                    tbProductosId(sbProducIdx));

      -- Obtiene los componentes asociados al producto
      pkg_bcgestion_producto.prcObtieneCompoxProduct(tbProductosId(sbProducIdx),
                                                     tbprComponenteId);

      sbComponIdx := tbprComponenteId.first;

      WHILE sbComponIdx IS NOT NULL LOOP
        -- Obtiene el estado anterior del componente
        nuValorAnteCompo := pkg_bcgestion_solicitudes.fnuObtieValorAnteriorAttri('PR_COMPONENT',
                                                                                 'COMPONENT_STATUS_ID',
                                                                                 nuMotiveId,
                                                                                 tbprComponenteId(sbComponIdx));

        -- Actualiza el estado del componente
        pkg_Componente_Producto.prcActEstadoPr_Component(tbprComponenteId(sbComponIdx),
                                                         nuValorAnteCompo);

        sbComponIdx := tbprComponenteId.NEXT(sbComponIdx);

      END LOOP;

      -- Obtiene el estado anterior del producto
      nuValorAnteProd := pkg_bcgestion_solicitudes.fnuObtieValorAnteriorAttri('PR_PRODUCT',
                                                                              'PRODUCT_STATUS_ID',
                                                                              nuMotiveId,
                                                                              tbProductosId(sbProducIdx));

      -- Actualiza el estado del producto
      pkg_producto.practualizaestadoproducto(tbProductosId(sbProducIdx),
                                             nuValorAnteProd);

      sbProducIdx := tbProductosId.NEXT(sbProducIdx);

    END LOOP;

    pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbmensaje);
      pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' ||
                      sbmensaje,
                      cnuNVLTRC);
      pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END prcReversaEstadoProducto;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActivaProductoSuspendido
    Descripcion     : proceso que activa producto suspendido
    Autor           : Jorge Valiente
    Fecha           : 23-04-2024

    Parametros de Entrada
      inuproduct_id     Identificador del producto
      idtsesufein   Fecha de instalación
    isbupdEstacort  Flag que indica si actualiza el estado de corte del producto (S/N)

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor           Fecha       Caso      Descripcion
  Jorge Valiente    23/05/2025  OSF-4489  Reubicar logica de insercion de registro en la entidad SUSPECONE
                                          Despelgar error para suspension por cartera si el estado de corte 
                                          no existe en el parametro ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD   
  ***************************************************************************/
  PROCEDURE prcActivaProductoSuspendido(inuOrden          number,
                                        inuOrdenActividad number,
                                        inuContrato       number,
                                        inuProducto       number) IS

    -- Nombre de este metodo
    csbMetodo   VARCHAR2(70) := csbNOMPKG || '.prcActivaProductoSuspendido';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error

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
      select ooa.order_activity_id OrdenActividad,
             s.sesunuse Servicio,
             s.sesususc Contrato,
             s.sesuserv TipoServicio,
             s.sesuesco EstadoCorteServicio,
             sys_context('USERENV', 'TERMINAL') Terminal,
             sys_context('USERENV', 'SESSION_USER') Usuario,
             pp.product_status_id EstadoProducto,
             s.sesucicl ciclo,
             oo.execution_final_date FechaFinalEjecucion
        from Or_Order_Activity ooa, servsusc s, or_order oo, pr_product pp
       where oo.order_id = inuOrden
         and oo.order_id = ooa.order_id
         and s.sesunuse = ooa.product_id
         and s.sesunuse = pp.product_id
         and ooa.final_date is null
         and ooa.task_type_id = oo.task_type_id;

    rfData cuData%rowtype;

    nuTipoServicio        number;
    nuEstadoCorteServicio number;
    nuEstadoProductoOrden number;
    nuCiclo               number;
    dtFechaFinalEjecucion date;
    sbTerminal            varchar2(4000);
    sbUsuario             varchar2(4000);

    --Variable para OSF-4489
    nuExisteESTADO_CORTE NUMBER;
    ----------------------------

  BEGIN

    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

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
    dtFechaFinalEjecucion := rfData.Fechafinalejecucion;
    sbTerminal            := rfData.Terminal;
    sbUsuario             := rfData.Usuario;

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

        if nuExisteEstadoServicio > 0 then

          --Actualiza estado de corte de servicio
          pkg_producto.prActualizaEstadoCorte(inuProducto,
                                              CNUESTADO_CONEXION_SERVSUSC);

        else
          --Valdiacion OSF-4489
          nuExisteESTADO_CORTE := pkg_parametros.fnuValidaSiExisteCadena('ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD',
                                                                         ',',
                                                                         nuEstadoCorteServicio);        
          pkg_traza.trace('Existe estado de corte [' ||
                          nuEstadoCorteServicio ||
                          '] en el parametro ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD - nuExisteESTADO_CORTE[' ||
                          nuExisteESTADO_CORTE || ']',
                          pkg_traza.cnuNivelTrzDef);
          --Validar si el estado de corte NO existe en el parametro ESTADO_CORTE_NO_ACTU_EN_ACTIVA_PROD
          IF nuExisteESTADO_CORTE = 0 THEN
            pkg_error.setErrorMessage(isbMsgErrr => 'El servicio [' ||
                                                    inuProducto ||
                                                    '] estan suspendido por cartera.');
          END IF;        
        end if; --if nuExisteEstadoServicio > 0 then

        --Inicio Registra DATA en SUSPCONE OSF-4489
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
        pkg_traza.trace('Agregar registro en la entidad SuspCone',
                        pkg_traza.cnuNivelTrzDef);        
        --Fin Registro DATA en SUSPCONE

      end if; --if nuTipoSuspension = 2 then

      --Actualiza Estado de Producto Suspendido
      pkg_producto.prActualizaEstadoProducto(inuProducto,
                                             CNUESTADO_ACTIVO_PRODUCTO);
      pkg_producto.prcActualizaUltActSuspension(inuProducto, null);

      --Inactiva la suspension del Producto
      pkg_pr_prod_suspension.prcInactivaSuspension(inuProducto,
                                                   dtFechaFinalEjecucion);

      --Actualiza estado de componente de Producto suspendido
      pkg_Componente_Producto.prActualizaEstadocomponente(inuProducto,
                                                          CNUESTADO_ACTIVO_COMPONENTE);

      --Inactiva la suspension del componente de suspension del de Producto
      FOR RC IN cuComponentes LOOP
        pkg_pr_comp_suspension.prcInactivaSuspension(RC.COMP_SUSPENSION_ID,
                                                     dtFechaFinalEjecucion);
      END LOOP;

      --Cancela la inclusion del producto
      pkg_inclusion_cartera.prcCancelaInclucion(inuProducto);

    end if; --if inuEstadoProdcuto = nuEstadoProducto then

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;

  end prcActivaProductoSuspendido;

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcActuaCateySubcaPorContrato
    Descripcion     : Actualiza categoria y subcategoría por contrato
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 25-11-2024

    Parametros de Entrada
    inucontrato       Contrato,
    inuCategoria      Categoría,
    inuSubCategoria   Subcategoría

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      	Descripcion
	jerazomvm	03/01/2025  OSF-3812 	1. Se elimina el cursor cuValidaCategoria
										2. Se elimina la validación de la categoria,
										   para que siempre se actualice la categoria
    fvalencia   13/02/2025  OSF-3984  	Se agrega el llamado al procedimiento
										pkg_bodirecciones.prcActuCategoriaySubcategoria
	jerazomvm	15/05/2025  OSF-4478	Se reversa los ajustes del caso OSF-3812
  ***************************************************************************/
  PROCEDURE prcActuaCateySubcaPorContrato
  (
    inucontrato       IN servsusc.sesususc%TYPE,
    inuCategoria      IN servsusc.sesucate%TYPE,
    inuSubCategoria   IN servsusc.sesusuca%TYPE
  )
  IS

		-- Nombre de este metodo
		csbMetodo   VARCHAR2(70) := csbNOMPKG || '.prcActuaCateySubcaPorContrato';
		nuErrorCode NUMBER; -- se almacena codigo de error
		sbMensError VARCHAR2(4000); -- se almacena descripcion del error
		nuCantidad  NUMBER;
		nuCategoria      servsusc.sesucate%TYPE;
		oclRespuesta    CLOB;
		onuCodigoError  NUMBER;
		osbMensajeError VARCHAR2(4000);
		
		CURSOR cuValidaCategoria (inucontrato   IN servsusc.sesususc%TYPE,
								  inuCategoria	IN servsusc.sesucate%TYPE
								  )
		IS
			SELECT  COUNT(1)
			FROM    servsusc 
			WHERE   sesususc = inucontrato
			AND     sesucate = inuCategoria;

  BEGIN

		pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	
		pkg_traza.trace('inucontrato: ' 	|| inucontrato 	|| CHR(10) ||
						'inuCategoria: ' 	|| inuCategoria || CHR(10) ||
						'inuSubCategoria: ' || inuSubCategoria, cnuNVLTRC);


		nuCategoria := inuCategoria;

		ldci_pkg_bointegragis.prcActCategoriaSubcategoria
		(
			inucontrato,
			nuCategoria,
			inuSubCategoria,
			oclRespuesta,
			onuCodigoError,
			osbMensajeError
		);

		IF NVL(onuCodigoError,0) = 0 THEN     

			IF (cuValidaCategoria%ISOPEN) THEN
				CLOSE cuValidaCategoria;
			END IF;
			
			OPEN cuValidaCategoria(inucontrato,inuCategoria);
			FETCH cuValidaCategoria INTO nuCantidad;
			CLOSE cuValidaCategoria;
			  
			IF (nuCantidad > 0) THEN
				nuCategoria :=  NULL;
			END IF;

			-- Actualiza la categoria y subcagoria del contrato
			pkg_producto.prcActuCategoriaySubcategoria(inucontrato,nuCategoria,inuSubCategoria);
			pkg_bodirecciones.prcActuCategoriaySubcategoria(inucontrato,nuCategoria,inuSubCategoria);
		ELSE
			Pkg_Error.SetErrorMessage(pkg_error.CNUGENERIC_MESSAGE, osbMensajeError);
		END IF;

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_Error.Controlled_Error THEN
			pkg_Error.getError(nuErrorCode, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			RAISE pkg_Error.Controlled_Error;
		 WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCode, sbMensError);
			pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;

  END prcActuaCateySubcaPorContrato;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prRetiraProductoSinInstal
    Descripcion     : Retira un producto y sus componentes
    Autor           : Lubin Pineda
    Fecha           : 27-01-2025

    Parametros de Entrada
    inuProducto       Producto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso      Descripcion
    ***************************************************************************/
    PROCEDURE prRetiraProductoSinInstal
    (
        inuProducto IN   pr_product.product_id%TYPE
    )
    IS
        -- Nombre de este metodo
        csbMetodo   VARCHAR2(70) := csbNOMPKG || 'prRetiraProductoSinInstal';
        nuError     NUMBER;
        sbError     VARCHAR2(4000);

        tbCompActivProducto pkg_bccomponentes.tytbCompActivProducto;

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        -- Se retira el producto
        pkg_Producto.prActualizaEstadoProducto( inuProducto, CNUESTADO_RET_SIN_INS_PRODUCTO );
        pkg_Producto.prActualizaFechaRetiro( inuProducto, CNUESTADO_RET_SIN_INS_SERVSUSC );

        tbCompActivProducto := pkg_bccomponentes.ftbObtCompActivProducto( inuProducto );

        IF tbCompActivProducto.COUNT > 0 THEN

            FOR indtbComp IN 1..tbCompActivProducto.COUNT LOOP

                pkg_Componente_Producto.prcRetiroComponente( tbCompActivProducto(indtbComp).Component_ID, cnuEST_RET_SIN_INST_COMPONENTE );

            END LOOP;

        ELSE
            pkg_traza.trace('El producto [' ||  inuProducto || '] no tiene componentes activos', pkg_traza.cnuNivelTrzDef );
        END IF;


        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prRetiraProductoSinInstal;

END PKG_GESTION_PRODUCTO;
/
begin
  pkg_utilidades.prAplicarPermisos('PKG_GESTION_PRODUCTO',
                                   'PERSONALIZACIONES');
end;
/